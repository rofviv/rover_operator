import 'package:dio/dio.dart';

import 'relay_model.dart';

abstract class RoverRepository {
  Future<void> getAllDataRover(String baseUrl);
  Future<RelayModel> getRelayRover(String baseUrl);
  Future<void> toggleRelayRover(String baseUrl, String relayNumber);
}

class RoverRepositoryImpl implements RoverRepository {
  final Dio dio = Dio();

  @override
  Future<void> getAllDataRover(String baseUrl) async {
    try {
      final response = await dio.get('http://$baseUrl/');
      print(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RelayModel> getRelayRover(String baseUrl) async {
    try {
      final response = await dio.get('http://$baseUrl/sync_data_relay');
      return RelayModel.fromMap(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> toggleRelayRover(String baseUrl, String relayNumber) async {
    try {
      final response = await dio.post(
        'http://$baseUrl/toggle_data_relay',
        data: {
          'relay_id': relayNumber,
        },
      );
      print(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
