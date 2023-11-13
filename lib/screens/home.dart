import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/actual_option.dart';
import '../widgets/navigatorbar.dart';
import 'create_student.dart';
import 'list_students.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Estudiantes")),
        ),
        body: _HomeScreenBody(),
        bottomNavigationBar: const CustomNavigatorBar());
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);

    int selectedOption = actualOptionProvider.selectedOption;

    switch (selectedOption) {
      case 0:
        return const ListStudentScreen();
      case 1:
        return const CreateStudentScreen();
      default:
        return const ListStudentScreen();
    }
  }
}
