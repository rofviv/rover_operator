import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import 'dashboard_widget.dart';
import 'bloc/dashboard_bloc.dart';
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
    i.addSingleton(DashboardBloc.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) =>
            DashboardWidget(dashboardBloc: Modular.get<DashboardBloc>()));
  }
}
