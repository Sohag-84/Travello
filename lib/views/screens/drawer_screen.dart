// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:travel_agency/views/drawer_page/settings/settings_screen.dart';
import 'package:travel_agency/views/widgets/drawer_item.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.orangeAccent.withOpacity(.08),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              // begin: const FractionalOffset(0.0, 0.0),
              // end: const FractionalOffset(1.0, 0.0),
              colors: [
                Colors.white.withOpacity(.10),
                Colors.orangeAccent.withOpacity(.10),
                Colors.white.withOpacity(.10),
                Colors.red.withOpacity(.10),
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 50.h, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.appName,
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                "Travel Agency",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 20.h,
              ),
              drawerItem(itemName: 'Support', onClick: null),
              SizedBox(height: 8.h),
              drawerItem(itemName: 'Privacy', onClick: null),
              SizedBox(height: 8.h),
              drawerItem(itemName: 'FAQ', onClick: null),
              SizedBox(height: 8.h),
              drawerItem(itemName: 'Rate us', onClick: null),
              SizedBox(height: 8.h),
              drawerItem(itemName: 'How to use', onClick: null),
              Expanded(
                child: SizedBox(),
              ),
              InkWell(
                onTap: () => Get.to(SettingScreen()),
                child: Text(
                  "Settings",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
