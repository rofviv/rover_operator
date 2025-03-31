import 'package:dio/dio.dart';
import 'package:rover_operator/app/core/preferences_repository.dart';

import '../dtos/login_dto.dart';
import '../models/user_model.dart';

abstract class PatioRepository {
  Future<UserModel> login(LoginDto dto);
  Future<UserModel?> getUserByToken();
}

class PatioRepositoryImpl implements PatioRepository {
  final Dio _dio;
  PreferencesRepository _preferencesRepository;

  PatioRepositoryImpl(this._dio, this._preferencesRepository);

  @override
  Future<UserModel> login(LoginDto dto) async {
    try {
      final response = await _dio.post(
        '/api/drivers/login',
        data: dto.toJson(),
      );
      await _preferencesRepository.setToken(response.data['data']['token']);
      return UserModel.fromJson(response.data['data']['user']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel?> getUserByToken() async {
    final token = await _preferencesRepository.token;
    if (token == null) {
      return null;
    }
    try {
      final response = await _dio.get(
        '/api/drivers/get/driver',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e);
    }
  }
}
