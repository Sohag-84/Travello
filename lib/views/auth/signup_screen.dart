// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_colors.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/controllers/auth_controller.dart';
import 'package:travel_agency/views/auth/login_screen.dart';
import 'package:travel_agency/views/styles.dart';
import 'package:travel_agency/views/widgets/violetButton.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final authController = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 80.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create\nYour Account",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.violetColor,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Create your account and start your journey......",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppStyles().textFieldDecoration("Full Name"),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppStyles().textFieldDecoration("E-mail Address"),
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: AppStyles().textFieldDecoration("Enter Password"),
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.text,
                  decoration: AppStyles().textFieldDecoration("Phone Number"),
                ),
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  decoration:
                      AppStyles().textFieldDecoration("Enter your address"),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Obx(
                  () {
                    return VioletButton(
                      isLoading: authController.isLoading.value,
                      title: 'Create Account',
                      onAction: () async{

                        authController.isLoading(true);

                       await authController.userRegistration(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          number: _phoneController.text.toString(),
                          address: _addressController.text,
                        );

                       authController.isLoading(false);
                      },
                    );
                  }
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "--OR--",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/google.png",
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/icons/facebook.png"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                RichText(
                  text: TextSpan(
                    text: "Already an user?  ",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Log In",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.violetColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignInScreen()),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
