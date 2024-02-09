import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_app_getx/model/student.dart';
import 'package:student_app_getx/services/functions.dart';
import 'package:student_app_getx/utils/constants.dart';
import 'package:student_app_getx/view/edit_screen/editscreen.dart';
import 'package:student_app_getx/view/widgets/student_list_widgets.dart';
import 'package:student_app_getx/view/student_search_screen/student_search_screen.dart';
import 'package:student_app_getx/view/widgets/app_bar_widget.dart';
import 'package:student_app_getx/view/widgets/floating_actionbutton.dart';
import 'package:student_app_getx/viewmodel/student_controller.dart';
import '../add_studentscreen.dart/add_student_screen.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentsController = Get.put(StudentController());
    studentsController.loadStudents();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: AppBarWidget(
          onTapRight: () {
            Get.to(const SearchStudentScreen());
          },
          righticon: Icons.search,
          title: 'STUDENTS LIST',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Obx(
            () {
              if (studentsController.students.isEmpty) {
                return const Text('No Student Found');
              } else {
                return ListView.separated(
                  physics: const ScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  separatorBuilder: (context, index) => Constants().kheight10,
                  itemCount: studentsController.students.length,
                  itemBuilder: (context, index) {
                    var student = studentsController.students[index];
                    return InkWell(
                      onTap: () => showStudentDetailsDialog(context, student),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: StudentCardWidget(student: student),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton:
          const FloatingActionButtonWidget(page: AddStudentScreen()),
    );
  }
}

class StudentCardWidget extends StatelessWidget {
  const StudentCardWidget({
    super.key,
    required this.student,
  });

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            Get.to(EditScreen(student: student));
          },
          icon: Icons.edit,
          backgroundColor: Colors.green,
        ),
        SlidableAction(
            onPressed: (context) {
              showDeleteConfirmationDialog(context, student);
            },
            icon: Icons.delete,
            backgroundColor: Colors.red)
      ]),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 130, 128, 128).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Constants().kWidth10,
                StudentImageContainerWidget(
                    student: student, height: 135, width: 135),
                Constants().kWidth10,
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name.toUpperCase(),
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Constants().kheight10,
                        Text(
                          'Age: ${student.age}',
                          style: GoogleFonts.openSans(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Department: ${student.department.toUpperCase()}',
                          style: GoogleFonts.openSans(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Phone No: ${student.phoneNumber}',
                          style: GoogleFonts.openSans(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
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
