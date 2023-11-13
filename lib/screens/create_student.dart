import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/services/student_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option.dart';
import '../providers/student_form.dart';

class CreateStudentScreen extends StatelessWidget {
  const CreateStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StudentService studentService = Provider.of(context);

    //Creando un provider solo enfocado al formulario
    return ChangeNotifierProvider(
        create: (_) => StudentFormProvider(studentService.selectedStudent),
        child: _CreateForm(studentService: studentService));
  }
}

class _CreateForm extends StatelessWidget {
  final StudentService studentService;

  const _CreateForm({required this.studentService});

  @override
  Widget build(BuildContext context) {
    final StudentFormProvider studentFormProvider =
        Provider.of<StudentFormProvider>(context);

    final student = studentFormProvider.student;

    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: studentFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: student.nombre,
            decoration: const InputDecoration(
                hintText: 'Ingrese su nombre',
                labelText: 'Nombre',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) => studentFormProvider.student.nombre = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            initialValue: student.apellido,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Ingrese su apellido',
              labelText: 'Apellido',
            ),
            onChanged: (value) => student.apellido = value,
            validator: (value) {
              return (value != null) ? null : 'El campo no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            maxLines: 1,
            autocorrect: false,
            initialValue: "",
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Ingrese su edad',
              labelText: 'Edad',
            ),
            onChanged: (value) => student.edad = int.tryParse(value)!,
            validator: (value) {
              return (value != null) ? null : 'El campo no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: studentService.isSaving
                ? null
                : () async {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!studentFormProvider.isValidForm()) return;
                    await studentService
                        .createOrUpdate(studentFormProvider.student);
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  studentService.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
