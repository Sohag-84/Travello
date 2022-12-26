// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_agency/views/widgets/custom_text_field.dart';
import 'package:travel_agency/views/widgets/violetButton.dart';

import 'package_add_next_page.dart';

class PackageAddPage extends StatefulWidget {
  const PackageAddPage({Key? key}) : super(key: key);

  @override
  State<PackageAddPage> createState() => _PackageAddPageState();
}

class _PackageAddPageState extends State<PackageAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _facilityController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                "If you have any problems, please contact us. We are at your service all the time.",
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              customTextField("Owner Name", _nameController),
              customTextField("Description", _descriptionController),
              customTextField("Cost", _costController),
              customTextField("Facilities", _facilityController, maxline: 4),
              customTextField("Destination", _destinationController),
              VioletButton(
                isLoading: false,
                title: "Next",
                onAction: () {
                  if(_nameController.text.isEmpty || _nameController.text.length <3){
                    Fluttertoast.showToast(msg: "Name must be at least 3 character");
                  }
                  else if(_descriptionController.text.isEmpty || _descriptionController.text.length <3){
                    Fluttertoast.showToast(msg: "description must be at least 3 character");
                  }
                  else if(_costController.text.isEmpty || _costController.text.length <3){
                    Fluttertoast.showToast(msg: "cost must be at least 3 character");
                  }
                  else if(_facilityController.text.isEmpty || _facilityController.text.length <3){
                    Fluttertoast.showToast(msg: "facility must be at least 3 character");
                  }
                  else if(_destinationController.text.isEmpty || _destinationController.text.length <3){
                    Fluttertoast.showToast(msg: "destination must be at least 3 character");
                  }
                  else{
                    Get.to(
                          () => PackageAddNextPage(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        cost: int.parse(_costController.text),
                        facility: _facilityController.text,
                        destination: _destinationController.text,
                      ),
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
