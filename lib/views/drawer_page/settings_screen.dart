// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/controllers/auth_controller.dart';
import 'package:travel_agency/views/drawer_page/profile_screen.dart';
import 'package:travel_agency/views/widgets/drawer_item.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  RxBool darkMode = false.obs;

  final authController = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.90),
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "darkMode",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                ),
                Obx(
                      () => Switch(
                    value: darkMode.value,
                    onChanged: (bool value) {
                      darkMode.value = value;

                    },
                  ),
                ),
              ],
            ),
            10.h.heightBox,
            drawerItem(itemName: "Profile", onClick: () {Get.to(()=> ProfileScreen());}),
            10.h.heightBox,
            drawerItem(itemName: "Language", onClick: () {}),
            10.h.heightBox,
            drawer(onPressed: () => authController.signOut(), title: "Logout"),
          ],
        ),
      ),
    );
  }
}
