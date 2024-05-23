import 'package:assempleyapp/Configurations/Screen.dart';
import 'package:assempleyapp/Pages/Assemplypage/Widgets/Assemblyscreen.dart';
import 'package:assempleyapp/helpers/constantRoutes.dart';
import 'package:assempleyapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/Utils.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    naviMethod();
  }

  naviMethod() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(ConstantRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child:Utils.network == 'none'
                    ? NoInternet(network: Utils.network)
                    :  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Screens.width(context) * 0.5,
              height: Screens.bodyheight(context) * 0.4,
              child: Column(
                children: [
                  ClipRect(child: Image.asset('assets/Logo Final.png')),
                  SizedBox(
                    width: Screens.width(context) * 0.3,
                    child: const LinearProgressIndicator(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
