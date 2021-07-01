import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:covidtracker/global/global_function.dart' as globalFunction;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginNotifier extends ChangeNotifier {
  String _email, _password;

  String get email {
    return _email;
  }

  String get password {
    return _password;
  }

  set email(String email) {
    this._email = email;
  }

  set password(String password) {
    this._password = password;
  }

  String _errorEmail = '';
  String _errorPassword = '';
  String _errorUndefined = '';
  bool _loginStatus = false;

  String get errorEmail {
    return _errorEmail;
  }

  String get errorPassword {
    return _errorPassword;
  }

  String get errorUndefined {
    return _errorUndefined;
  }

  bool get loginStatus {
    return _loginStatus;
  }

  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<bool> login(String email, password) async {
    bool status = false;
    var server = await globalFunction.getServer();
    var url = Uri.http(server, '/api/login');
    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {'email': email, 'password': password},
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      setToken(result['token']);
      status = true;
    } else if (response.statusCode == 400) {
      if (result['email'] != null) {
        var listErrorEmail = result['email'];
        var strErrorEmail = listErrorEmail.join('\n');
        _errorEmail = strErrorEmail;
      } else {
        _errorEmail = '';
        _errorUndefined = '';
      }
      if (result['password'] != null) {
        var listErrorPassword = result['password'];
        var strErrorPassword = listErrorPassword.join('\n');
        _errorPassword = strErrorPassword;
      } else {
        _errorPassword = '';
        _errorUndefined = '';
      }
    } else {
      if (result['message'] != null) {
        _errorEmail = '';
        _errorPassword = '';
        _errorUndefined = result['message'];
      } else {
        _errorUndefined = '';
      }
    }
    notifyListeners();
    return status;
  }
}
