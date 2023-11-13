import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/services/student_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option.dart';

class ListStudentScreen extends StatelessWidget {
  const ListStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ListStudent();
  }
}

class _ListStudent extends StatelessWidget {
  void displayDialog(
      BuildContext context, StudentService studentService, String id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Cuidado!'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    '¿Seguro que quieres eliminar a este estudiante de la lista?'),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    studentService.deleteStudentById(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Si')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    StudentService studentService = Provider.of<StudentService>(context);
    //noteService.loadNotes();
    final students = studentService.students;

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.person),
        title: Text("${students[index].nombre} ${students[index].apellido}"),
        subtitle: Text("${students[index].edad} años"),
        trailing: PopupMenuButton(
          // icon: Icon(Icons.fire_extinguisher),
          onSelected: (int i) {
            if (i == 0) {
              studentService.selectedStudent = students[index];
              Provider.of<ActualOptionProvider>(context, listen: false)
                  .selectedOption = 1;
              return;
            }

            displayDialog(context, studentService, students[index].id!);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 0, child: Text('Actualizar')),
            const PopupMenuItem(value: 1, child: Text('Eliminar'))
          ],
        ),
      ),
    );
  }
}
