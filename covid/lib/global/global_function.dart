import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('token');
  return stringValue;
}

getServer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('server');
  return stringValue;
}

Future<List> getProvince() async {
  List data = [];
  var server = await getServer();
  var url = Uri.http(server, '/api/wilayah/province');
  final response = await http.get(
    url,
    headers: {"Accept": "application/json"},
  );
  var result = json.decode(response.body);
  if (response.statusCode == 200) {
    data = result['data'];
  }
  return data;
}

Future<bool> check() async {
  bool status = false;
  var server = await getServer();
  if (server != null) {
    var token = await getToken();
    var url = Uri.http(server, '/api/check');
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 401) {
      status = false;
    } else {
      status = true;
    }
  } else {
    status = false;
  }
  return status;
}
