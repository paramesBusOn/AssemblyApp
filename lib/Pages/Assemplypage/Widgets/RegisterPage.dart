//
import 'package:assempleyapp/Configurations/Screen.dart';
import 'package:assempleyapp/Controller/registerController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<RegisterController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[200],
          // gradient: LinearGradient(
          //   tileMode: TileMode.mirror,
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Colors.orange.shade100,
          //     // Colors.white,
          //     Colors.grey[200]!,
          //     // Colors.white,

          //     // Theme.of(context).colorScheme.primary.withOpacity(0.3),
          //     // Theme.of(context).colorScheme.primary,

          //     // Theme.of(context)
          //     //     .colorScheme
          //     //     .primary
          //     //     .withOpacity(0.7),
          //   ],
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     offset: const Offset(3.0, 4.0),
          //     blurRadius: 4,
          //     color: Colors.black.withOpacity(0.3),
          //   )
          // ]
        ),
        child: SingleChildScrollView(
          child: Form(
            key: context.read<RegisterController>().formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.05,
                ),
                Center(
                  child: Container(
                    height: Screens.padingHeight(context) * 0.15,
                    width: Screens.width(context) * 0.6,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
                  height: Screens.bodyheight(context) * 0.03,
                ),
                TextFormField(
                  controller: context.read<RegisterController>().mycontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Name',
                    contentPadding: const EdgeInsets.all(18.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                DropdownButtonFormField(
                    key: context.watch<RegisterController>().key,
                    isExpanded: true, //Adding this property, does the magic
                    // value: context.read<RegisterController>().clubname,
                    validator: (value) =>
                        value == null ? 'Field required' : null,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Choose Club',
                      contentPadding: const EdgeInsets.all(18.0),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: context
                        .read<RegisterController>()
                        .item
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        context.read<RegisterController>().clubname = val;
                      });
                    }),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          context.read<RegisterController>().isEmpty!
                              ? 'Signature Pad is empty*'
                              : 'Signature Pad is filled properly',
                          style: theme.textTheme.titleMedium!.copyWith(
                              color: context.read<RegisterController>().isEmpty!
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                      ],
                    ),
                    Container(
                      width: Screens.width(context),
                      height: Screens.bodyheight(context) * 0.34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 15,
                              color: Colors.black26,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: SfSignaturePad(
                        key: context.read<RegisterController>().signaturePadKey,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    IconButton(
                      onPressed: context
                          .read<RegisterController>()
                          .handleClearButtonPressed,
                      icon: const Icon(Icons.refresh),
                    )
                  ],
                ),
                // SizedBox(
                //   height: Screens.bodyheight(context) * 0.02,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                                color: Colors.black.withOpacity(0.3),
                              )
                            ]),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<
                                    Color>(Colors.white),
                                shadowColor: MaterialStateProperty.all(Colors
                                    .transparent),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                            onPressed:
                                context.read<RegisterController>().progreess ==
                                        true
                                    ? null
                                    : () {
                                        setState(() {
                                          context
                                              .read<RegisterController>()
                                              .handleSaveButtonPressed(
                                                  context, theme);
                                        });
                                      },
                            child:
                                context.watch<RegisterController>().progreess ==
                                        true
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Register',
                                        style: TextStyle(fontSize: 18),
                                      )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
