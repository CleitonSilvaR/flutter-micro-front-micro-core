import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'micro_core_utils.dart';
import 'microapp.dart';

abstract class BaseApp {
  List<MicroApp>? get microApps;

  Map<String, WidgetBuilderArgs>? get baseRoutes;

  final Map<String, WidgetBuilderArgs> routes = {};

  void registerRoutes() {
    if (baseRoutes?.isNotEmpty ?? false) routes.addAll(baseRoutes!);
    if (microApps?.isNotEmpty ?? false) {
      for (MicroApp microapp in microApps!) {
        routes.addAll(microapp.routes);
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    var routerName = settings.name;
    var routerArgs = settings.arguments;
    if (routerName == null || routerArgs == null) return null;

    var navigateTo = routes[routerName];
    if (navigateTo == null) return null;

    return MaterialPageRoute(
      builder: (context) => navigateTo.call(context, routerArgs),
    );
  }
}
