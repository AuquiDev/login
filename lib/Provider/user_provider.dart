// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/utils/api_key.dart';
import 'package:login/model/user_model.dart';

class RecursosProvider extends ChangeNotifier {
  final String _baseUrl = 'api.sheety.co';
  final String _api_key = '$pathKey/recursos';

  List<User> recursoList = [];
  late User selectedUser;

  File? newPictureFile; //aqui almacenamos la imagen

  bool isaving = false;

  RecursosProvider() {
    print('Recursos Usuario Inicializado');
    getRecursosProvider();
  }

  getRecursosProvider() async {
    var url = Uri.https(_baseUrl, '$pathKey/user', {
      'api_key': _api_key,
    });

    final response = await http.get(url);
    final decodeData = UsuarioModel.fromJson(response.body);

    recursoList = decodeData.user;
    notifyListeners();
  }

  //guardar cambios

  Future saveOrCreateProduct(User user) async {
    isaving = true;
    notifyListeners();

    if (user.id == null) {
      //es nesesario crear usuario
      await createUSer(user);
    } else {
      await updateUSer(user);
    }

    isaving = false;
    notifyListeners();
  }

  Future<String> updateUSer(User user) async {
    // //
    //   final picker =new ImagePicker();
    //     final PickedFile? pickerFile = await picker.getImage(
    //                   source: ImageSource.gallery,
    //                   imageQuality: 100//calidad de la imagen
    //                   );
    // //

    var url = Uri.https(_baseUrl, '$pathKey/user/${user.id}', {
      'api_key': _api_key,
    });
    final response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
        },
        body:
            // user.toJson()
            json.encode({
          "user": {
            "nombreCompleto": user.nombreCompleto,
            "apellido": user.apellido,
            "genero": user.genero,
            "role": user.role,
            "dni": user.dni,
            "password": user.password,
            "cargo": user.cargo,
            "direccion": user.direccion,
            "telefono": user.telefono,
            "correo": user.correo,
            "estatus": user.estatus,
            // "calification": 0,
            "image": user.image,
          }
        }));
    final decodeData = response.body;
    print(decodeData);
    // final decodeData = UsuarioModel.fromJson(response.body);
    //ACTULIZAR EL LISTADO DE PRODUCTOS
    final index = recursoList.indexWhere((element) => element.id == user.id);
    recursoList[index] = user;
    return '${user.id}';
  }

  Future<String> createUSer(User user) async {
    var url = Uri.https(_baseUrl, '$pathKey/user', {
      'api_key': _api_key,
    });
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          // "user": {
          //   "nombreCompleto": user.nombreCompleto,
          //   "password": "alberto",
          //   "estatus": user.estatus,
          //   "calification": 0,
          //   "dni": 70031725,
          //   "direccion": "Av. lima Norte",
          //   "telefono": 976357951,
          //   "role": user.role,
          //   "image": user.image
          //   // "https://i.pinimg.com/564x/2b/19/23/2b1923256426b986cf253c35fe262158.jpg",
          //   // "id": 2
          // },
          "user": {
            "nombreCompleto": user.nombreCompleto,
            "apellido": user.apellido,
            "genero": user.genero,
            "role": user.role,
            "dni": user.dni,
            "password": user.password,
            "cargo": user.cargo,
            "direccion": user.direccion,
            "telefono": user.telefono,
            "correo": user.correo,
            "estatus": user.estatus,
            // "calification": 0,
            "image": user.image,
          }
        }));
    final decodeData = json.decode(response.body);
    // final decodeData = response.body;
    user.id = decodeData["user"]["id"];
    print(decodeData);

    recursoList.add(user);
    return '${user.id}';
  }

  //CAMBIAR LA IMAGEN EN LA VISTA PREVIA
  void updateSelectedUserImage(String paths) {
    selectedUser.image = paths;
    newPictureFile =
        File.fromUri(Uri(path: paths)); //buscar archivo, y va crear el archivo

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    isaving = true;

    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dw2vwrqem/image/upload?upload_preset=y8etxxjt');
    final imageUploadrequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadrequest.files.add(file);

    final streamResponse = await imageUploadrequest.send();

    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Algo salio mal');
      print(response.body);
      return null;
    }

    newPictureFile = null;

    final decodeData = json.decode(response.body);

    return decodeData['secure_url'];
  }
}
