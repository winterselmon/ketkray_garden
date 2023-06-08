import 'package:flutter/material.dart';
import 'package:ketkray_garden/constant/color_helper.dart';
import 'package:ketkray_garden/utils/function_widgets.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  static const routeName = '/manage';

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  late double height;
  late double width;
  late bool isPortrait;
  late double textScaleFector;

  

  @override
  Widget build(BuildContext context) {
    height = screenHeight(context);
    width = screenWidth(context);
    isPortrait = screenIsPortrait(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            color: ColorHelper.grayColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
