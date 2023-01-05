
import 'package:flutter/material.dart';
import 'package:login/model/user_model.dart';

class UserFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User userform;

  UserFormProvider(this.userform);

  updateAvailability(bool value){
    print(value);
    this.userform.estatus = value;
    notifyListeners();
  }
  
  bool isValidation(){
    print(userform.nombreCompleto);
    print(userform.role);
    print(userform.estatus);
    print(userform.direccion);
    return formKey.currentState!.validate() ?? false;
  }
}