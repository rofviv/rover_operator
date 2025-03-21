import 'package:dio/dio.dart';

import 'relay_model.dart';
import 'rover_status_mode.dart';

abstract class RoverRepository {
  Future<RoverStatusModel> getStatusRover(String baseUrl);
  Future<RelayModel> getRelayRover(String baseUrl);
  Future<RelayModel> toggleRelayRover(String baseUrl, String relayNumber);
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
}
