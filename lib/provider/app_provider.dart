
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class AppProvider extends ChangeNotifier {

  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel newUser){
    _user = newUser;
    notifyListeners();
  }

  void clearUser(){
    _user = null;
    notifyListeners();
  }


}