import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import 'blocs/location/location_bloc.dart';
import 'dashboard_widget.dart';
import 'blocs/dashboard/dashboard_bloc.dart';
import 'data/rover_repository.dart';

class DashboardModule extends Module {
  static String route = "/dashboard/";

  @override
  List<Module> get imports => [
    AppModule(),
  ];

  @override
  void binds(Injector i) {
    i.addSingleton<RoverRepository>(RoverRepositoryImpl.new);
    i.addSingleton(LocationBloc.new);
    i.addSingleton(DashboardBloc.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) =>
            DashboardWidget(dashboardBloc: Modular.get<DashboardBloc>(), locationBloc: Modular.get<LocationBloc>()));
  }
}
