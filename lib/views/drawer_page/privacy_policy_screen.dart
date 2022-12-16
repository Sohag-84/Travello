// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy policy")),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: privacyPolicyText.text.size(22.sp).make(),
      ),
    );
  }
}
