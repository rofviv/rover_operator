import 'package:dio/dio.dart';

import 'relay_model.dart';
import 'rover_status_mode.dart';

abstract class RoverRepository {
  Future<RoverStatusModel> getStatusRover(String baseUrl);
  Future<RelayModel> getRelayRover(String baseUrl);
  Future<RelayModel> toggleRelayRover(String baseUrl, String relayNumber);
  Future<RoverStatusModel> setSonarFrontSensor(String baseUrl, bool sonarSensor);
  Future<RoverStatusModel> setLatency(String baseUrl, bool latency);
}

class RoverRepositoryImpl implements RoverRepository {
  final Dio dio = Dio();

  @override
  Future<RoverStatusModel> getStatusRover(String baseUrl) async {
    try {
      final response = await dio.get('http://$baseUrl/');
      return RoverStatusModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RelayModel> getRelayRover(String baseUrl) async {
    try {
      final response = await dio.get('http://$baseUrl/sync_data_relay');
      return RelayModel.fromMap(response.data["data"]);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RelayModel> toggleRelayRover(
      String baseUrl, String relayNumber) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/toggle_data_relay',
        data: {
          'relay_id': relayNumber,
        },
      );
      return RelayModel.fromMap(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<RoverStatusModel> setLatency(String baseUrl, bool latency) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/set_latency_status',
        data: {
          'latency_status': latency ? "1" : "0",
        },
      );
      return RoverStatusModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RoverStatusModel> setSonarFrontSensor(String baseUrl, bool sonarSensor) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/set_sonar_front_status',
        data: {
          'sonar_front_status': sonarSensor ? "1" : "0",
        },
      );
      return RoverStatusModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
