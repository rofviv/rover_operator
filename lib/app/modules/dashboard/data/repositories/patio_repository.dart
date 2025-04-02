import 'package:dio/dio.dart';
import 'package:rover_operator/app/core/preferences_repository.dart';
import 'package:rover_operator/app/modules/dashboard/data/dtos/fetch_orders_dto.dart';

import '../dtos/create_timing_dto.dart';
import '../dtos/login_dto.dart';
import '../models/driver_timing_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';
import '../models/zone_model.dart';

abstract class PatioRepository {
  Future<UserModel> login(LoginDto dto);
  Future<UserModel?> getUserByToken();
  Future<List<Order>> getOrdersByDriver(FetchOrdersDto dto);
  Future<DriverTimingModel?> getDriverCurrentTiming();
  Future<void> createTiming(CreateTimingDto dto);
  Future<List<ZoneModel>> getZonesByCityId(int cityId);
  Future<void> updateStatusOrder(int driverOrderId, String status);
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

  @override
  Future<List<Order>> getOrdersByDriver(FetchOrdersDto dto) async {
    final token = await _preferencesRepository.token;
    if (token == null) {
      return [];
    }
    try {
      final response = await _dio.get(
        '/api/driver-order/orders/driver',
        queryParameters: dto.toMap(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return Order.fromList(response.data['data'] as List<dynamic>);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DriverTimingModel?> getDriverCurrentTiming() async {
    final token = await _preferencesRepository.token;
    if (token == null) {
      return null;
    }
    try {
      final response = await _dio.get(
        '/api/driver-timings/current/timing',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return DriverTimingModel.fromJson((response.data['data'] as List).first);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> createTiming(CreateTimingDto dto) async {
    final token = await _preferencesRepository.token;
    if (token == null) {
      return;
    }
    try {
      await _dio.post(
        '/api/timings/specific-user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: dto.toMap(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ZoneModel>> getZonesByCityId(int cityId) async {
    final token = await _preferencesRepository.token;
    if (token == null) {
      return [];
    }
    try {
      final response = await _dio.get(
        '/api/zones/city/$cityId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return ZoneModel.fromList(response.data['data'] as List<dynamic>);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateStatusOrder(int driverOrderId, String status) async {
    final token = await _preferencesRepository.token;
    if (token == null) {
      return;
    }
    try {
      await _dio.put(
        '/api/orders/driver/change-status/$driverOrderId',
        data: {
          "status": status,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
