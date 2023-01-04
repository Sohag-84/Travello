import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  updateData({required uid}) {
    var ref = firestore.collection(usersCollection).doc(uid);
    try {
      ref
          .update({
            'name': nameController.text,
            'email': emailController.text,
            'phone_number': phoneController.text,
            'address': addressController.text,
          })
          .then(
            (value) => Fluttertoast.showToast(
                msg: "Updated Successfully", backgroundColor: Colors.black87),
          )
          .then(
            (value) => Get.back(),
          );
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something is wrong", backgroundColor: Colors.black87);
    }
  }
}
