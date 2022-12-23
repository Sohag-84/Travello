// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelfTourScreen extends StatelessWidget {
  const SelfTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: 30,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 212, 196, 196),
                borderRadius: BorderRadius.all(Radius.circular(7.r)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7.r),
                      topRight: Radius.circular(7.r),
                    ),
                    child: Image.network(
                      "https://www.travelmate.com.bd/wp-content/uploads/2022/02/Nikli-Haor-Road-1000x530.jpg",
                      height: 145.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    "Kishoreganj",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color.fromARGB(255, 59, 80, 27),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "2499 BDT",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
