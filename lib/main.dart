import 'package:assempleyapp/Configurations/Screen.dart';
import 'package:assempleyapp/Controller/assemblyController.dart';
import 'package:assempleyapp/Pages/Assemplypage/Screens/ConfigurationScreen.dart';
import 'package:assempleyapp/helpers/allRoutes.dart';
import 'package:assempleyapp/helpers/constantRoutes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'helpers/Utils.dart';
import 'themes/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  networkcheck();
  runApp(const MyApp());
}

networkcheck() async {
  Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    if (result.name == 'none') {
      Utils.network = 'none';
      print("network none");
    } else {
      await Future.delayed(const Duration(seconds: 5));

      Utils.network = 'true';
      print("network Online");
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result.name == 'none') {
        if (!mounted) return;

        setState(() {
          Utils.network = 'none';
        });
        print("network none");
      } else {
        await Future.delayed(const Duration(seconds: 5));
        if (!mounted) return;

        setState(() {
          Utils.network = 'true';
        });
        print("network Online");
      }
    });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => AssemblyController()),
      ],
      child: Consumer<ThemeManager>(builder: (context, themes, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color.fromARGB(255, 41, 99, 2)),
              useMaterial3: true,
              fontFamily: 'LeagueSpartan_Font'),
          getPages: Routes.allRoutes,
          home: const ConfigurationPage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoInternet extends StatefulWidget {
  const NoInternet({super.key, required this.network});
  final String network;
  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _controller = AnimationController(
        vsync: this,
      );
      _controller.value = 0.5;

      connectivitycheck();
    });
  }

  connectivitycheck() async {
    await Future.delayed(const Duration(seconds: 5));
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result.name == 'none') {
        setState(() {
          Utils.network = "none";

          _controller.stop();
        });
        print("network none");
      } else {
        setState(() {
          Utils.network = "true";
          _controller.forward();
        });
        await Future.delayed(const Duration(seconds: 10));
        print("network Online Animation");
      }
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        width: Screens.width(context),
        height: Screens.bodyheight(context),
        child: Center(
          child: Column(
            // alignment: Alignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Lottie.asset(
                fit: BoxFit.fill,
                repeat: false,
                controller: _controller,
                'assets/nonetwork.json',
                onLoaded: (composition) {
                  _controller.duration = composition.duration;
                },
                reverse: true,

                // repeat: false,
                // animate: widget.network == 'none' ? false : true
              ),
              SizedBox(
                width: Screens.width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No Internet Connection",
                      style: theme.textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "check your Internet connection \n try again..!",
                      style: theme.textTheme.titleMedium!.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if(Utils.network!='none'){
Get.offAllNamed(ConstantRoutes.dashboard)  ;                          }
                          });
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
