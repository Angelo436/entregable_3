import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  String? id;
  String nombre = "";
  String apellido = "";
  int edad = 0;

  Student({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.edad,
  });

  String toJson() => json.encode(toMap());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      edad: json["edad"]);

  Map<String, dynamic> toMap() => {
        //"id": id,
        "nombre": nombre,
        "apellido": apellido,
        'edad': edad,
      };
}
