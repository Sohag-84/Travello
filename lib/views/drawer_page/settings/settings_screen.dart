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
      //backgroundColor: Colors.white.withOpacity(.90),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Setting".tr,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.person, size: 50.h),
            title: Text("Sohag"),
            subtitle: Text("sohag@gmail.com"),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              children: [
                Text(
                  "Packages:",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                30,
                (index) {
                  return ListTile(
                    leading: Image.network(
                        "https://www.travelmate.com.bd/wp-content/uploads/2022/02/Nikli-Haor-Road-1000x530.jpg"),
                    title: Text("Nikli"),
                    subtitle: Text("2399 BDT"),
                    trailing: PopupMenuButton(
                      itemBuilder: (context)=>[
                        PopupMenuItem(
                          child: InkWell(
                            onTap: () {
                              // controller.approvedPackage(docId: data.id);
                              // Fluttertoast.showToast(msg: "Approved");
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(width: 10.w),
                                Text("Delete"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
