// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromMap(jsonString);

import 'dart:convert';

class UsuarioModel {
    UsuarioModel({
       required this.user,
    });

    List<User> user;

    factory UsuarioModel.fromJson(String str) => UsuarioModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        user: List<User>.from(json["user"].map((x) => User.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "user": List<dynamic>.from(user.map((x) => x.toMap())),
    };
}

class User {
    User({
      required  this.nombreCompleto,
      required  this.password,
      required  this.estatus,
      required  this.calification,
      required  this.dni,
      required  this.direccion,
      required  this.telefono,
      required  this.role,
      required  this.id,
    });

    String nombreCompleto;
    String password;
    bool estatus;
    int calification;
    int dni;
    String direccion;
    int telefono;
    String role;
    int id;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        nombreCompleto: json["nombreCompleto"],
        password: json["password"],
        estatus: json["estatus"],
        calification: json["calification"],
        dni: json["dni"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        role: json["role"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "nombreCompleto": nombreCompleto,
        "password": password,
        "estatus": estatus,
        "calification": calification,
        "dni": dni,
        "direccion": direccion,
        "telefono": telefono,
        "role": role,
        "id": id,
    };
}
