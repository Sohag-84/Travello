// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/controllers/auth_controller.dart';
import 'package:travel_agency/views/drawer_page/settings/profile_screen.dart';
import 'package:travel_agency/views/widgets/drawer_item.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  RxBool darkMode = false.obs;

  final authController = Get.put(AuthController());

  Future changeLanguage(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select your language!"),
        content: SizedBox(
          height: 200.h,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Get.updateLocale(
                    const Locale('bn', 'BD'),
                  );
                  Get.back();
                },
                child: const Text("Bangla"),
              ),
              SizedBox(
                width: 10.w,
              ),
              TextButton(
                onPressed: () {
                  Get.updateLocale(
                    const Locale('en', 'US'),
                  );
                  Get.back();
                },
                child: const Text("English"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.90),
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Setting".tr,
        ),
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
                  "darkMode".tr,
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
            drawerItem(
                itemName: "Profile".tr,
                onClick: () {
                  Get.to(() => ProfileScreen());
                }),
            10.h.heightBox,
            drawerItem(
                itemName: "languages".tr,
                onClick: () {
                  changeLanguage(context);
                }),
            10.h.heightBox,
            drawer(onPressed: () => authController.signOut(), title: "logout".tr),
          ],
        ),
      ),
    );
  }
}
