import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rover_operator/app/core/preferences_repository.dart';
import 'package:rover_operator/app/modules/dashboard/data/repositories/patio_repository.dart';

import '../../app_module.dart';
import 'blocs/location/location_bloc.dart';
import 'blocs/session/session_bloc.dart';
import 'dashboard_widget.dart';
import 'blocs/dashboard/dashboard_bloc.dart';
import 'data/repositories/rover_repository.dart';

// const String baseUrlPatio = 'https://patio-driver-test.patiodelivery2.com';
const String baseUrlPatio = 'https://www.patio-driver.patiodelivery2.com';

class DashboardModule extends Module {
  static String route = "/dashboard/";

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton<RoverRepository>(RoverRepositoryImpl.new);
    i.addSingleton<PatioRepository>(
      () => PatioRepositoryImpl(
        Dio()..options.baseUrl = baseUrlPatio,
        Modular.get<PreferencesRepository>(),
      ),
    );
    i.addSingleton(SessionBloc.new);
    i.addSingleton(LocationBloc.new);
    i.addSingleton(DashboardBloc.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => DashboardWidget(
              dashboardBloc: Modular.get<DashboardBloc>(),
              locationBloc: Modular.get<LocationBloc>(),
              sessionBloc: Modular.get<SessionBloc>(),
            ));
  }
}
