import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget drawerItem({required String itemName, required onClick}) {
  return InkWell(
    onTap: onClick,
    child: Text(
      itemName,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
    ),
  );
}
