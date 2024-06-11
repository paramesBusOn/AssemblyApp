// ignore_for_file: deprecated_member_use

import 'dart:collection';
import 'dart:io';

import 'package:assempleyapp/Configurations/Screen.dart';
import 'package:assempleyapp/Controller/assemblyController.dart';
import 'package:assempleyapp/Pages/Assemplypage/Widgets/QrScannar.dart';
import 'package:assempleyapp/Pages/Assemplypage/Widgets/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:math' as math;

import '../../../helpers/Utils.dart';
import '../../../main.dart';

class AssemblyPagState extends StatefulWidget {
  const AssemblyPagState({super.key});

  @override
  State<AssemblyPagState> createState() => AssemblyPagStateState();
}

class AssemblyPagStateState extends State<AssemblyPagState> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<AssemblyController>().init();
      Utils.network;
    });
  }

  static List<Shadow> outlinedText(
      {double strokeWidth = 2,
      Color strokeColor = Colors.black,
      int precision = 5}) {
    Set<Shadow> result = HashSet();
    for (int x = 1; x < strokeWidth + precision; x++) {
      for (int y = 1; y < strokeWidth + precision; y++) {
        double offsetX = x.toDouble();
        double offsetY = y.toDouble();
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
      }
    }
    return result.toList();
  }

  DateTime? currentBackPressTime;
  Future<bool> dialogBackBun() {
    //if is not work check material app is on the code
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    // print("objectqqqqq");
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //     // centerTitle: true,
        //     // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //     // title: const Text('Assembly App'),
        //     ),
        body: Container(
            height: Screens.padingHeight(context),
            width: Screens.width(context),
            alignment: Alignment.center,
            child: Utils.network == 'none'
                ? NoInternet(network: Utils.network)
                : Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // Positioned(
                      //     top: 0,
                      //     child: Transform.rotate(
                      //       angle: -math.pi / 4,
                      //       child: Container(
                      //         width: Screens.width(context) * 0.6,
                      //         height: Screens.bodyheight(context) * 0.3,
                      //         decoration: BoxDecoration(
                      //           color: theme.primaryColor,
                      //           // boxShadow: [
                      //           //   BoxShadow(
                      //           //     color: theme.primaryColor.withOpacity(0.3),
                      //           //     blurRadius: 200
                      //           //   )
                      //           // ]
                      //         ),
                      //       ),
                      //     )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: Screens.padingHeight(context) * 0.15,
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.greenAccent.shade100,
                                        blurRadius: 8,
                                        spreadRadius: 0.8),
                                  ]),
                              child: const Center(
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/Logo Final.png')),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.05,
                          ),
                          Center(
                            child: SizedBox(
                              height: Screens.padingHeight(context) * 0.3,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.05,
                                          width: Screens.width(context) * 0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              // color:
                                              //     Theme.of(context).colorScheme.primary,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.orange.shade300,

                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  // Theme.of(context).colorScheme.primary,

                                                  // Theme.of(context)
                                                  //     .colorScheme
                                                  //     .primary
                                                  //     .withOpacity(0.7),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset:
                                                      const Offset(3.0, 4.0),
                                                  blurRadius: 4,
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                )
                                              ]),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                  shadowColor:
                                                      MaterialStateProperty.all(
                                                          Colors.transparent),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.transparent),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ))),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            const RegisterPage())));
                                              },
                                              child: const Text(
                                                'Register',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.02,
                                  ),
                                  Container(
                                    width: Screens.width(context),
                                    decoration: BoxDecoration(
                                        // color: Theme.of(context).colorScheme.primary,
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            Colors.orange.shade300,
                                            Colors.orange.shade300,

                                            Theme.of(context)
                                                .colorScheme
                                                .primary,

                                            // Theme.of(context)
                                            //     .colorScheme
                                            //     .primary
                                            //     .withOpacity(0.7),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(1.0, 4.0),
                                            blurRadius: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          )
                                        ]
                                        // borderRadius: BorderRadius.circular(4),
                                        ),
                                    alignment: Alignment.center,
                                    height:
                                        Screens.padingHeight(context) * 0.05,
                                    child: const Text(
                                      'ASSEMBLY',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: Screens.padingHeight(context) *
                                            0.05,
                                        width: Screens.width(context) * 0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            // color:
                                            //     Theme.of(context).colorScheme.primary,
                                            gradient: LinearGradient(
                                              colors: [
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                // Theme.of(context).colorScheme.primary,

                                                Colors.orange.shade300,

                                                // Theme.of(context)
                                                //     .colorScheme
                                                //     .primary
                                                //     .withOpacity(0.7),
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3.0, 4.0),
                                                blurRadius: 4,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )
                                            ]),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ))),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          QrScanner(
                                                            event: 'Assembly',
                                                            type: 'Breakfast', 
                                                          ))));
                                            },
                                            child: const Text(
                                              'Breakfast',
                                              style: TextStyle(fontSize: 18),
                                            )),
                                      ),
                                      Container(
                                        height: Screens.padingHeight(context) *
                                            0.05,
                                        width: Screens.width(context) * 0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            // color:
                                            //     Theme.of(context).colorScheme.primary,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.orange.shade300,

                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                // Theme.of(context).colorScheme.primary,

                                                // Theme.of(context)
                                                //     .colorScheme
                                                //     .primary
                                                //     .withOpacity(0.7),
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3.0, 4.0),
                                                blurRadius: 4,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )
                                            ]),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ))),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          QrScanner(
                                                            event: 'Assembly',
                                                            type: 'Lunch',
                                                          ))));
                                            },
                                            child: const Text(
                                              'Lunch',
                                              style: TextStyle(fontSize: 18),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.02,
                          ),
                          Container(
                            height: Screens.padingHeight(context) * 0.05,
                            width: Screens.width(context) * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                // color:
                                //     Theme.of(context).colorScheme.primary,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.shade300,

                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.primary,

                                    Colors.orange.shade300,

                                    // Theme.of(context)
                                    //     .colorScheme
                                    //     .primary
                                    //     .withOpacity(0.7),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(3.0, 4.0),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.3),
                                  )
                                ]),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => QrScanner(
                                                event: 'Shiksha',
                                                type: 'Shiksha',
                                              ))));
                                },
                                child: const Text(
                                  'Shiksha',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.06,
                          ),
                          Container(
                            height: Screens.padingHeight(context) * 0.05,
                            width: Screens.width(context) * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                // color:
                                //     Theme.of(context).colorScheme.primary,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.shade300,

                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.primary,

                                    Colors.orange.shade300,

                                    // Theme.of(context)
                                    //     .colorScheme
                                    //     .primary
                                    //     .withOpacity(0.7),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(3.0, 4.0),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.3),
                                  )
                                ]),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => QrScanner(
                                                event: 'Jalak',
                                                type: 'Jalak',
                                              ))));
                                },
                                child: const Text(
                                  'Jalak',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.02,
                          ),
                          const Divider(),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.08,
                          ),
                          Container(
                            height: Screens.padingHeight(context) * 0.04,
                            width: Screens.width(context) * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                // color:
                                //     Theme.of(context).colorScheme.primary,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.shade300,

                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.primary,

                                    Colors.orange.shade300,

                                    // Theme.of(context)
                                    //     .colorScheme
                                    //     .primary
                                    //     .withOpacity(0.7),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(3.0, 4.0),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.3),
                                  )
                                ]),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                onPressed: () {
                                  setState(() {
                                    context
                                        .read<AssemblyController>()
                                        .createExcel(context, theme);
                                  });
                                },
                                child: const Text(
                                  'Export',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                        ],
                      ),
                    ],
                  )),
      ),
    );
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Are you sure?"),
            // content: Text("Do you want to exit?"),
            content: Container(
              width: Screens.width(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade300,

                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary,

                    Colors.orange.shade300,

                    // Theme.of(context)
                    //     .colorScheme
                    //     .primary
                    //     .withOpacity(0.7),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 40),
                      width: Screens.width(context) * 0.85,
                      child: const Divider(
                        color: Colors.grey,
                      )),
                  Container(
                      alignment: Alignment.center,
                      // width: Screens.width(context)*0.5,
                      // padding: EdgeInsets.only(left:20),
                      child: const Text(
                        "Are you sure",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),
                  Container(
                      alignment: Alignment.center,
                      // padding: EdgeInsets.only(left:20),
                      child: const Text("Do you want to exit?",
                          style: TextStyle(fontSize: 15, color: Colors.white))),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: theme.primaryColor,
                              textStyle: const TextStyle(color: Colors.white),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(0),
                              )),
                            ),
                            onPressed: () {
                              exit(0);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: theme.primaryColor,
                              textStyle: const TextStyle(color: Colors.white),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                              )),
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop(false);
                              });
                              // context.read<EnquiryUserContoller>().checkDialogCon();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )) ??
        false;
  }
}
