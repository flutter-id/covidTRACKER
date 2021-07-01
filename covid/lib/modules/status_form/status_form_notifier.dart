import 'package:flutter/cupertino.dart';
import 'package:lancong/global/global_function.dart' as globalFunction;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatusFormNotifier extends ChangeNotifier {
  String _errorDate = '';
  String _errorName = '';
  String _errorOccupation = '';
  String _errorInstitution = '';
  String _errorTypeId = '';
  String _errorStatus = '';
  String _errorDescription = '';

  String _errorUndefined = '';

  String get errorDate {
    return _errorDate;
  }

  String get errorName {
    return _errorName;
  }

  String get errorOccupation {
    return _errorOccupation;
  }

  String get errorInstitution {
    return _errorInstitution;
  }

  String get errorTypeId {
    return _errorTypeId;
  }

  String get errorStatus {
    return _errorStatus;
  }

  String get errorDescription {
    return _errorDescription;
  }

  String get errorUndefined {
    return _errorUndefined;
  }

  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<bool> statusStore(String date, name, occupation, institution, typeId,
      status, description) async {
    bool statusResult = false;
    var server = await globalFunction.getServer();
    var token = await globalFunction.getToken();
    var url = Uri.http(server, '/api/status');
    final response = await http.post(
      url,
      headers: {"Accept": "application/json", 'Authorization': 'Bearer $token'},
      body: {
        'date': date,
        'name': name,
        'occupation': occupation,
        'institution': institution,
        'type_id': typeId,
        'status': status,
        'description': description,
      },
    );
    var result = json.decode(response.body);
    if (response.statusCode == 201) {
      statusResult = true;
    } else if (response.statusCode == 400) {
      if (result['date'] != null) {
        var listErrorDate = result['date'];
        var strErrorDate = listErrorDate.join('\n');
        _errorDate = strErrorDate;
      } else {
        _errorDate = '';
      }
      if (result['name'] != null) {
        var listErrorName = result['name'];
        var strErrorName = listErrorName.join('\n');
        _errorName = strErrorName;
      } else {
        _errorName = '';
      }
      if (result['occupation'] != null) {
        var listErrorOccupation = result['occupation'];
        var strErrorOccupation = listErrorOccupation.join('\n');
        _errorOccupation = strErrorOccupation;
      } else {
        _errorOccupation = '';
      }
      if (result['institution'] != null) {
        var listErrorInstitution = result['institution'];
        var strErrorInstitution = listErrorInstitution.join('\n');
        _errorInstitution = strErrorInstitution;
      } else {
        _errorInstitution = '';
      }
      if (result['typeId'] != null) {
        var listErrorTypeId = result['typeId'];
        var strErrorTypeId = listErrorTypeId.join('\n');
        _errorTypeId = strErrorTypeId;
      } else {
        _errorTypeId = '';
      }
      if (result['status'] != null) {
        var listErrorStatus = result['status'];
        var strErrorStatus = listErrorStatus.join('\n');
        _errorStatus = strErrorStatus;
      } else {
        _errorStatus = '';
      }
      if (result['description'] != null) {
        var listErrorDescription = result['description'];
        var strErrorDescription = listErrorDescription.join('\n');
        _errorDescription = strErrorDescription;
      } else {
        _errorDescription = '';
      }
    } else {
      if (result['message'] != null) {
        _errorUndefined = result['message'];
      } else {
        _errorUndefined = '';
      }
    }
    notifyListeners();
    return statusResult;
  }
}
