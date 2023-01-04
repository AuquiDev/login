
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/Provider/api_key.dart';
import 'package:login/model/user_model.dart';


class RecursosProvider extends ChangeNotifier {
  String _baseUrl = 'api.sheety.co';
  String _api_key = '$pathKey/recursos';
  
  List<User> recursoList= [];
  RecursosProvider(){
    print('Recursos Usuario Inicializado');
    getRecursosProvider();
  }

  getRecursosProvider() async{
  //https://api.sheety.co/6121e3168e4127572ba4c604c9934ea5/distritosDeLaProvinciaDeUrubamba/user
    var url = Uri.https(_baseUrl,'$pathKey/user',{
      'api_key': _api_key,
    });

    final response = await http.get(url);
    final decodeData = UsuarioModel.fromJson(response.body);
    
    recursoList = decodeData.user;
    print(decodeData.user[0].nombreCompleto);
    print(decodeData.user[0].password);
    notifyListeners();

  }
  
}