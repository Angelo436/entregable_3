import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/models/student.dart';
import 'package:notes_api_crud_app/services/student_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final StudentService studentService = Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      //Current Index, para determinar el botón que debe marcarse
      currentIndex: currentIndex,
      onTap: (int i) {
        if (i == 1) {
          studentService.selectedStudent =
              Student(nombre: '', apellido: '', edad: 0);
        }
        actualOptionProvider.selectedOption = i;
      },
      //Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Estudiantes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_add), label: "Agregar estudiante")
      ],
    );
  }
}
