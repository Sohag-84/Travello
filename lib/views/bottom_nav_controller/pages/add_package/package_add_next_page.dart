// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/views/screens/home_screen.dart';
import 'package:travel_agency/views/styles.dart';
import 'package:travel_agency/views/widgets/custom_text_field.dart';
import 'package:travel_agency/views/widgets/violetButton.dart';

class PackageAddNextPage extends StatefulWidget {
  final String name;
  final String description;
  final int cost;
  final String facility;
  final String destination;
  const PackageAddNextPage({
    Key? key,
    required this.name,
    required this.description,
    required this.cost,
    required this.facility,
    required this.destination,
  }) : super(key: key);

  @override
  State<PackageAddNextPage> createState() => _PackageAddNextPageState();
}

class _PackageAddNextPageState extends State<PackageAddNextPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _destinationDateController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var authCredential = firebaseAuth.currentUser;
  // FirebaseStorage storage = FirebaseStorage.instance;
  List<XFile>? multipleImages;
  List<String> imageUrlList = [];
  Future multipleImagePicker() async {
    multipleImages = await _picker.pickMultiImage();
    setState(() {});
  }

  Future uploadImages() async {
    try {
      if (multipleImages != null) {
        AppStyles().progressDialog(context);
        for (int i = 0; i < multipleImages!.length; i += 1) {
          // upload to stroage
          File imageFile = File(multipleImages![i].path);

          UploadTask uploadTask = firebaseStorage
              .ref('${authCredential!.email}')
              .child(multipleImages![i].name)
              .putFile(imageFile);
          TaskSnapshot snapshot = await uploadTask;
          String imageUrl = await snapshot.ref.getDownloadURL();
          imageUrlList.add(imageUrl);
        }

        // upload to database
        uploadToDB();
      } else {
        Fluttertoast.showToast(msg: "Something is wrong.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed");
      Get.back();
    }
  }

  uploadToDB() {
    if (imageUrlList.isNotEmpty) {
      CollectionReference data = firestore.collection("all-data");
      data.doc().set(
        {
          "owner_name": widget.name,
          "description": widget.description,
          "approved": false,
          "forYou": true,
          "topPlaces":
              widget.cost >= 2000 && widget.cost <= 5000 ? true : false,
          "economy": widget.cost <= 3000 ? true : false,
          "luxury": widget.cost >= 10000 ? true : false,
          "cost": widget.cost,
          "facilities": widget.facility,
          "destination": widget.destination,
          "phone": _phoneNumberController.text,
          'date_time': DateTime.now(),
          "gallery_img":
              FieldValue.arrayUnion(imageUrlList), //we create image list
        },
      ).whenComplete(
        () => Fluttertoast.showToast(msg: "Uploaded Successfully."),
      );
      Get.to(
        () => HomeScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 40.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField("Phone Number", _phoneNumberController),
                customTextField(
                    "Destination Date & Time", _destinationDateController),
                Text(
                  "Choose Images",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFE9EBED),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.r),
                    ),
                  ),
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: () => multipleImagePicker(),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: multipleImages?.length ?? 0,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SizedBox(
                          width: 100,
                          child: multipleImages?.length == null
                              ? const Center(
                                  child: Text("Images are empty"),
                                )
                              : Image.file(
                                  File(multipleImages![index].path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                VioletButton(
                  isLoading: false,
                  title: "Upload",
                  onAction: () async {
                    if (_phoneNumberController.text.isEmpty ||
                        _phoneNumberController.text.length < 11) {
                      Fluttertoast.showToast(
                          msg: "phone number must be at least 11 character");
                    } else if (_destinationDateController.text.isEmpty ||
                        _destinationDateController.text.length < 3) {
                      Fluttertoast.showToast(
                          msg: "description must be at least 5 character");
                    } else {
                      uploadImages();
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
