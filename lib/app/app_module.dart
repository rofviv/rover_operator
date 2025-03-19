import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/modules.dart';
class AppModule extends Module {
  @override
  void exportedBinds(i) {
    i.addLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: '',
        ),
      ),
    );
  }

  @override
  void routes(r) {
    r.module(SplashModule.route, module: SplashModule());
    r.module(DashboardModule.route, module: DashboardModule());
  }
}