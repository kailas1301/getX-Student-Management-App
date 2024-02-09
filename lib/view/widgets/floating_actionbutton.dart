import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/utils/constants.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
    this.page,
  });
  final dynamic page;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 5,
        backgroundColor: Constants().appColor,
        onPressed: () {
          Get.to(page);
        },
        child: Icon(
          Icons.add,
          color: Constants().whiteColor,
        ));
  }
}
