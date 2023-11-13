import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Student student;

  StudentFormProvider(this.student);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
