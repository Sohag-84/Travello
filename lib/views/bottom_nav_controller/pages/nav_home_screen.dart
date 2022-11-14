// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/views/bottom_nav_controller/details_screen.dart';
import 'package:travel_agency/views/bottom_nav_controller/see_all_screen_2.dart';
import 'package:travel_agency/views/bottom_nav_controller/see_all_screen_3.dart';
import 'package:travel_agency/views/bottom_nav_controller/search_screen.dart';
import 'package:travel_agency/views/bottom_nav_controller/see_all_screen.dart';
import 'package:travel_agency/views/bottom_nav_controller/see_all_screen_3.dart';
import 'package:travel_agency/views/widgets/nav_home_categories.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({super.key});

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  final List _carouselImages = [
    'assets/images/cover-one.jpeg',
    'assets/images/cover-two.jpeg',
    'assets/images/cover-three.jpeg'
  ];

  final RxInt _currentIndex = 0.obs;

  //queryName
  late Future<QuerySnapshot> _futureDataForYou;
  late Future<QuerySnapshot> _futureDataRecentlyAdded;
  late Future<QuerySnapshot> _futureDataTopPlaces;
  late Future<QuerySnapshot> _futureDataEconomyPackage;
  late Future<QuerySnapshot> _futureDataLuxeryPackage;

  //collectionName
  final CollectionReference _refference = firestore.collection('all-data');

  @override
  void initState() {
    _futureDataForYou = _refference.where('phone', isNotEqualTo: '').get();
    _futureDataRecentlyAdded =
        _refference.orderBy("date_time", descending: true).get();
    _futureDataTopPlaces = _refference
        .where('cost', isGreaterThanOrEqualTo: 2000, isLessThanOrEqualTo: 5000)
        .get();
    _futureDataEconomyPackage =
        _refference.where('cost', isLessThan: 3000, isGreaterThan: 500).get();
    _futureDataLuxeryPackage =
        _refference.where('cost', isGreaterThan: 10000).get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 245, 237),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 200.h,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.9,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(() {
                        _currentIndex.value = val;
                      });
                    }),
                items: _carouselImages.map((image) {
                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 5.h),
            Obx(
              () => DotsIndicator(
                dotsCount: _carouselImages.length,
                position: _currentIndex.value.toDouble(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
                bottom: 10.h,
              ),
              child: InkWell(
                onTap: () => Get.to(
                  () => SearchScreen(),
                ),
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_outlined,
                          size: 20.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Search for your next tour",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            navHomeCategories(
              categoryName: "For You",
              onClick: () => Get.to(
                () => SeeAllScreen(
                  compare: "phone",
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 180.h,
              child: FutureBuilder<QuerySnapshot>(
                future: _futureDataForYou,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return forYou(items);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text("");
                },
              ),
            ),
            SizedBox(height: 15.h),
            navHomeCategories(
              categoryName: "Recently Added",
              onClick: () => Get.to(
                () => SeeAllScreen(
                  compare: 'date_time',
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 180.h,
              child: FutureBuilder<QuerySnapshot>(
                future: _futureDataRecentlyAdded,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return recentlyAdded(items);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(height: 15.h),
            navHomeCategories(
              categoryName: "Top Places",
              onClick: () => Get.to(
                () => SeeAllScreen(
                  compare: "cost",
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 80.h,
              child: FutureBuilder<QuerySnapshot>(
                future: _futureDataTopPlaces,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return topPlaces(items);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(height: 25.h),
            //Economy package
            navHomeCategories(
              categoryName: "Economy",
              onClick: () => Get.to(
                () => SeeAllScreen3(),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 180.h,
              child: FutureBuilder<QuerySnapshot>(
                future: _futureDataEconomyPackage,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return economyPackage(items);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text("");
                },
              ),
            ),
            //Luxury package
            SizedBox(height: 25),
            navHomeCategories(
              categoryName: "Luxury",
              onClick: () => Get.to(
                () => SeeAllScreen2(),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 180.h,
              child: FutureBuilder<QuerySnapshot>(
                future: _futureDataLuxeryPackage,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return luxuryPackage(items);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text("");
                },
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

List<Map> parseData(QuerySnapshot querySnapshot) {
  List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
  List<Map> listItems = listDocs
      .map((e) => {
            'list_images': e['gallery_img'],
            'list_destination': e['destination'],
            'list_cost': e['cost'],
            'list_description': e['description'],
            'list_facilities': e['facilities'],
            'list_owner_name': e['owner_name'],
            'list_phone': e['phone'],
            'list_date': e['date_time'],
          })
      .toList();
  return listItems;
}

Widget recentlyAdded(List<Map<dynamic, dynamic>> items) {
  return SizedBox(
    height: 180.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (_, index) {
        Map thisItem = items[index];
        return Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: InkWell(
            onTap: ()=> Get.to(()=> DetailsScreen(detailsData: thisItem),),
            child: Container(
              width: 100.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: Color(0xFfC4C4C4),
                borderRadius: BorderRadius.all(
                  Radius.circular(7.r),
                ),
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
                      thisItem['list_images'][0],
                      height: 115.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    thisItem['list_destination'],
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "${thisItem['list_cost']} BDT",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

ListView forYou(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: ()=> Get.to(()=> DetailsScreen(detailsData: thisItem),),
          child: Container(
            width: 100.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
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
                    thisItem['list_images'][0],
                    height: 115.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  thisItem['list_destination'],
                  style: TextStyle(fontSize: 15.sp),
                ),
                Text(
                  "${thisItem['list_cost']} BDT",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ListView topPlaces(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: InkWell(
          onTap: ()=> Get.to(()=> DetailsScreen(detailsData: thisItem),),
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(thisItem['list_images'][0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    },
  );
}

ListView economyPackage(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: ()=> Get.to(()=> DetailsScreen(detailsData: thisItem),),
          child: Container(
            width: 100.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
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
                    thisItem['list_images'][0],
                    height: 115.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  thisItem['list_destination'],
                  style: TextStyle(fontSize: 15.sp),
                ),
                Text(
                  "${thisItem['list_cost']} BDT",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ListView luxuryPackage(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 100.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
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
                    thisItem['list_images'][0],
                    height: 115.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  thisItem['list_destination'],
                  style: TextStyle(fontSize: 15.sp),
                ),
                Text(
                  "${thisItem['list_cost']} BDT",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
