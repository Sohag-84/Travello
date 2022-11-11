import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget detailsHeadingDescription({required title, required description}) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22.sp,
          ),
        ),
        Text(
          description,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    ),
  );
}
