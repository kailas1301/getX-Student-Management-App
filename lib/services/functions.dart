import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_app_getx/model/student.dart';
import 'package:student_app_getx/utils/constants.dart';
import 'package:student_app_getx/view/add_studentscreen.dart/add_student_screen.dart';
import 'package:student_app_getx/view/widgets/student_list_widgets.dart';

void snackBarFunction({
  required String title,
  required String subtitle,
  Duration? animationDuration,
  SnackPosition? snackPosition,
  Color? backgroundColor,
  DismissDirection? dismissDirection,
}) {
  Get.snackbar(title, subtitle,
      animationDuration: animationDuration,
      isDismissible: true,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      dismissDirection: dismissDirection);
}

void showDeleteConfirmationDialog(BuildContext context, StudentModel student) {
  Get.defaultDialog(
      title: 'Delete Student',
      content: Text('Are you sure you want to delete ${student.name}?'),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Cancel'),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          studentsController.deleteStudent(int.parse(student.id.toString()));
        },
        child: const Text('Delete'),
      ));
}

void showStudentDetailsDialog(BuildContext context, StudentModel student) {
  Get.dialog(
    Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 550,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Constants().kheight20,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StudentImageContainerWidget(
                    student: student,
                    height: 300,
                    width: 300,
                  ),
                ),
                Constants().kheight20,
                Text(
                  student.name.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Constants().kheight20,
                Text(
                  'Age: ${student.age}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Department: ${student.department.toUpperCase()}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Place: ${student.place}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Guardian Name: ${student.guardianName}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Phone No: ${student.phoneNumber}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
