import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class StudentService extends ChangeNotifier {
  final String _baseUrl = "bd-api-0-default-rtdb.firebaseio.com";

  late Student selectedStudent;

  List<Student> students = [];

  bool isLoading = false;
  bool isSaving = false;

  StudentsService() {
    loadNotes();
  }

  Future<List<Student>> loadNotes() async {
    isLoading = true;
    notifyListeners();
    students = [];

    final url = Uri.https(_baseUrl, 'Estudiante.json');
    final resp = await http.get(url);

    final Map<String, dynamic> studentsMap;

    if (json.decode(resp.body) != null) {
      studentsMap = json.decode(resp.body);
      studentsMap.forEach((key, value) {
        Student temp = Student.fromJson(value);
        temp.id = key;
        students.add(temp);
      });
    }

    isLoading = false;
    notifyListeners();

    return students;
  }

  Future createOrUpdate(Student student) async {
    isSaving = true;

    if (student.id == null) {
      await createStudent(student);
    } else {
      await updateStudent(student);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createStudent(Student student) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'Estudiante.json');
    final resp = await http.post(url, body: student.toJson());

    final decodedData = json.decode(resp.body);

    loadNotes();
    return decodedData['name'];
  }

  Future<String?> updateStudent(Student student) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'Estudiante/${student.id}.json');
    final resp = await http.put(url, body: student.toJson());

    return student.id;
  }

  Future<String> deleteStudentById(String id) async {
    isLoading = true;
    final url = Uri.https(_baseUrl, 'Estudiante/$id.json');
    final resp = await http.delete(url, body: {"id": id});

    loadNotes();
    return id;
  }
}
