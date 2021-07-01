import 'package:flutter/cupertino.dart';
import 'package:covidtracker/global/global_function.dart' as globalFunction;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileNotifier extends ChangeNotifier {
  String _errorName = '';
  String _errorEmail = '';
  String _errorPassword = '';
  String _errorPasswordConfirmation = '';
  String _errorPhoto = '';
  String _errorAddress = '';
  String _errorGender = '';
  String _errorBirthPlace = '';
  String _errorBirthDate = '';
  String _errorOccupation = '';
  String _errorVillageId = '';

  String _errorUndefined = '';
  bool _loginStatus = false;

  String get errorName {
    return _errorName;
  }

  String get errorEmail {
    return _errorEmail;
  }

  String get errorPassword {
    return _errorPassword;
  }

  String get errorPasswordConfirmation {
    return _errorPasswordConfirmation;
  }

  String get errorPhoto {
    return _errorPhoto;
  }

  String get errorAddress {
    return _errorAddress;
  }

  String get errorGender {
    return _errorGender;
  }

  String get errorBirthPlace {
    return _errorBirthPlace;
  }

  String get errorBirthDate {
    return _errorBirthDate;
  }

  String get errorOccupation {
    return _errorOccupation;
  }

  String get errorVillageId {
    return _errorVillageId;
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

  Future<bool> register(
      String name,
      email,
      password,
      passwordConfirmation,
      // photo,
      address,
      gender,
      birthPlace,
      birthDate,
      occupation,
      villageId) async {
    bool status = false;
    var server = await globalFunction.getServer();
    var url = Uri.http(server, '/api/register');
    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        // 'photo': photo,
        'address': address,
        'gender': gender,
        'birth_place': birthPlace,
        'birth_date': birthDate,
        'occupation': occupation,
        'village_id': villageId
      },
    );
    var result = json.decode(response.body);
    if (response.statusCode == 201) {
      setToken(result['token']);
      status = true;
    } else if (response.statusCode == 400) {
      if (result['name'] != null) {
        var listErrorName = result['name'];
        var strErrorName = listErrorName.join('\n');
        _errorName = strErrorName;
      } else {
        _errorName = '';
      }
      if (result['email'] != null) {
        var listErrorEmail = result['email'];
        var strErrorEmail = listErrorEmail.join('\n');
        _errorEmail = strErrorEmail;
      } else {
        _errorEmail = '';
      }
      if (result['password'] != null) {
        var listErrorPassword = result['password'];
        var strErrorPassword = listErrorPassword.join('\n');
        _errorPassword = strErrorPassword;
      } else {
        _errorPassword = '';
      }
      if (result['password_confirmation'] != null) {
        var listErrorPasswordConfirmation = result['password_confirmation'];
        var strErrorPasswordConfirmation =
            listErrorPasswordConfirmation.join('\n');
        _errorPasswordConfirmation = strErrorPasswordConfirmation;
      } else {
        _errorPasswordConfirmation = '';
      }
      if (result['address'] != null) {
        var listErrorAddress = result['address'];
        var strErrorAddress = listErrorAddress.join('\n');
        _errorAddress = strErrorAddress;
      } else {
        _errorAddress = '';
      }
      if (result['gender'] != null) {
        var listErrorGender = result['gender'];
        var strErrorGender = listErrorGender.join('\n');
        _errorGender = strErrorGender;
      } else {
        _errorGender = '';
      }
      if (result['birth_place'] != null) {
        var listErrorBirthPlace = result['birth_place'];
        var strErrorBirthPlace = listErrorBirthPlace.join('\n');
        _errorBirthPlace = strErrorBirthPlace;
      } else {
        _errorBirthPlace = '';
      }
      if (result['birth_date'] != null) {
        var listErrorBirthDate = result['birth_date'];
        var strErrorBirthDate = listErrorBirthDate.join('\n');
        _errorBirthDate = strErrorBirthDate;
      } else {
        _errorBirthDate = '';
      }
      if (result['occupation'] != null) {
        var listErrorOccupation = result['occupation'];
        var strErrorOccupation = listErrorOccupation.join('\n');
        _errorOccupation = strErrorOccupation;
      } else {
        _errorOccupation = '';
      }
      if (result['village_id'] != null) {
        var listErrorVillageId = result['village_id'];
        var strErrorVillageId = listErrorVillageId.join('\n');
        _errorVillageId = strErrorVillageId;
      } else {
        _errorVillageId = '';
      }
    } else {
      if (result['message'] != null) {
        _errorUndefined = result['message'];
      } else {
        _errorUndefined = '';
      }
    }
    notifyListeners();
    return status;
  }

  Future<bool> update(
      String name,
      email,
      password,
      passwordConfirmation,
      // photo,
      address,
      gender,
      birthPlace,
      birthDate,
      occupation,
      villageId) async {
    bool status = false;
    var server = await globalFunction.getServer();
    var token = await globalFunction.getToken();
    var url = Uri.http(server, '/api/update');
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        // 'photo': photo,
        'address': address,
        'gender': gender,
        'birth_place': birthPlace,
        'birth_date': birthDate,
        'occupation': occupation,
        'village_id': villageId
      },
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      status = true;
    } else if (response.statusCode == 400) {
      if (result['name'] != null) {
        var listErrorName = result['name'];
        var strErrorName = listErrorName.join('\n');
        _errorName = strErrorName;
      } else {
        _errorName = '';
      }
      if (result['email'] != null) {
        var listErrorEmail = result['email'];
        var strErrorEmail = listErrorEmail.join('\n');
        _errorEmail = strErrorEmail;
      } else {
        _errorEmail = '';
      }
      if (result['password'] != null) {
        var listErrorPassword = result['password'];
        var strErrorPassword = listErrorPassword.join('\n');
        _errorPassword = strErrorPassword;
      } else {
        _errorPassword = '';
      }
      if (result['password_confirmation'] != null) {
        var listErrorPasswordConfirmation = result['password_confirmation'];
        var strErrorPasswordConfirmation =
            listErrorPasswordConfirmation.join('\n');
        _errorPasswordConfirmation = strErrorPasswordConfirmation;
      } else {
        _errorPasswordConfirmation = '';
      }
      if (result['address'] != null) {
        var listErrorAddress = result['address'];
        var strErrorAddress = listErrorAddress.join('\n');
        _errorAddress = strErrorAddress;
      } else {
        _errorAddress = '';
      }
      if (result['gender'] != null) {
        var listErrorGender = result['gender'];
        var strErrorGender = listErrorGender.join('\n');
        _errorGender = strErrorGender;
      } else {
        _errorGender = '';
      }
      if (result['birth_place'] != null) {
        var listErrorBirthPlace = result['birth_place'];
        var strErrorBirthPlace = listErrorBirthPlace.join('\n');
        _errorBirthPlace = strErrorBirthPlace;
      } else {
        _errorBirthPlace = '';
      }
      if (result['birth_date'] != null) {
        var listErrorBirthDate = result['birth_date'];
        var strErrorBirthDate = listErrorBirthDate.join('\n');
        _errorBirthDate = strErrorBirthDate;
      } else {
        _errorBirthDate = '';
      }
      if (result['occupation'] != null) {
        var listErrorOccupation = result['occupation'];
        var strErrorOccupation = listErrorOccupation.join('\n');
        _errorOccupation = strErrorOccupation;
      } else {
        _errorOccupation = '';
      }
      if (result['village_id'] != null) {
        var listErrorVillageId = result['village_id'];
        var strErrorVillageId = listErrorVillageId.join('\n');
        _errorVillageId = strErrorVillageId;
      } else {
        _errorVillageId = '';
      }
    } else {
      if (result['message'] != null) {
        _errorUndefined = result['message'];
      } else {
        _errorUndefined = '';
      }
    }
    notifyListeners();
    return status;
  }

  Future<bool> logout() async {
    bool status = false;
    var server = await globalFunction.getServer();
    var token = await globalFunction.getToken();
    var url = Uri.http(server, '/api/logout');
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      setToken('');
      status = true;
    } else {
      if (result['message'] != null) {
        _errorUndefined = result['message'];
      } else {
        _errorUndefined = '';
      }
    }
    notifyListeners();
    return status;
  }
}
