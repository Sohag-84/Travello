// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_agency/controllers/auth_controller.dart';
import 'package:travel_agency/views/bottom_nav_controller/pages/nav_home_screen.dart';
import 'package:travel_agency/views/bottom_nav_controller/pages/package_add_page.dart';
import 'package:travel_agency/views/bottom_nav_controller/pages/self_tour_screen.dart';

//Page
List pages = [
  NavHomeScreen(),
  PackageAddPage(),
  SelfTourScreen(),
];
//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

//Controller
var authController = AuthController.instance;
