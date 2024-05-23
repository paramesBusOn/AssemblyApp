import 'package:assempleyapp/Pages/Assemplypage/Widgets/Assemblyscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';import 'constantRoutes.dart';

class Routes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.dashboard,
        page: () => const AssemblyPagState(
            ),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
  
  ];
}
