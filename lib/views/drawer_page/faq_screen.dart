// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Few Questions and Answer"
                .text
                .size(28.sp)
                .fontWeight(FontWeight.w500)
                .makeCentered(),
            40.h.heightBox,
            customExpansionTile(title: faqTitle1, description: faqDescription1),
            10.heightBox,
            customExpansionTile(title: faqTitle2, description: faqDescription1),
          ],
        ),
      ),
    );
  }

  ExpansionTile customExpansionTile(
      {required String title, required String description}) {
    return ExpansionTile(
      backgroundColor: Colors.green.withOpacity(.50),
      collapsedTextColor: Colors.green,
      iconColor: Colors.white,
      textColor: Colors.white,
      childrenPadding: EdgeInsets.all(10.h),
      title: Text(title),
      children: [description.text.black.make()],
    );
  }
}
