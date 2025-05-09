import 'package:dio/dio.dart';

import '../models/relay_model.dart';
import '../models/rover_status_mode.dart';

abstract class RoverRepository {
  Future<RoverStatusModel> getStatusRover(String baseUrl);
  Future<RelayModel> getRelayRover(String baseUrl);
  Future<RelayModel> toggleRelayRover(String baseUrl, String relayNumber);
  Future<RoverStatusModel> setSonarFrontSensor(
      String baseUrl, bool sonarSensor);
  Future<RoverStatusModel> setSonarBackSensor(String baseUrl, bool sonarSensor);
  Future<RoverStatusModel> setLatency(String baseUrl, bool latency);
  Future<RoverStatusModel> setLidar(String baseUrl, bool lidar);
  Future<RoverStatusModel> setLidarDistance(String baseUrl, String lidarDistance);
  Future<RoverStatusModel> setLidarAngle(String baseUrl, String lidarAngle);
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
  Future<RoverStatusModel> setSonarFrontSensor(
      String baseUrl, bool sonarSensor) async {
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

  @override
  Future<RoverStatusModel> setSonarBackSensor(
      String baseUrl, bool sonarSensor) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/set_sonar_back_status',
        data: {
          'sonar_back_status': sonarSensor ? "1" : "0",
        },
      );
      return RoverStatusModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RoverStatusModel> setLidar(String baseUrl, bool lidar) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/set_lidar_status',
        data: {
          'lidar_status': lidar ? "1" : "0",
        },
      );
      return RoverStatusModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<RoverStatusModel> setLidarDistance(String baseUrl, String lidarDistance) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/set_lidar_distance',
        data: {
          'lidar_distance': lidarDistance,
        },
      );
      return RoverStatusModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<RoverStatusModel> setLidarAngle(String baseUrl, String lidarAngle) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/set_lidar_angle',
        data: {
          'lidar_angle': lidarAngle,
        },
      );
      return RoverStatusModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
