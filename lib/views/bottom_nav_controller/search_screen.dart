import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search for your next tour",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
