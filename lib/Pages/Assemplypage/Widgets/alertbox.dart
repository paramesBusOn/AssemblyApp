// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:assempleyapp/Configurations/Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Alertbox extends StatefulWidget {
  Alertbox({Key? key}) : super(key: key);
  @override
  State<Alertbox> createState() => _AlertboxState();
}

class _AlertboxState extends State<Alertbox> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(08),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: displayDialog(context));
  }

  Container displayDialog(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return Container(
        width: Screens.width(context),
        padding: EdgeInsets.all(10),
        child: Container(
            width: Screens.width(context),
            height: Screens.fullHeight(context) * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            )));
  }
}
