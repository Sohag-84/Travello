// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/views/bottom_nav_controller/pages/bottom_nav_controller_screen.dart';
import 'package:travel_agency/views/screens/drawer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future _exitDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are u sure to close this app?"),
          content: Row(
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text("No"),
              ),
              SizedBox(
                width: 20.w,
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Yes"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _exitDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            BottomNavControllerScreen(),
          ],
        ),
      ),
    );
  }
}
