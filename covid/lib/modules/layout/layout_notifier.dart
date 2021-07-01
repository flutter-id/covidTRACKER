import 'package:flutter/cupertino.dart';
import 'package:lancong/global/global_function.dart' as globalFunction;
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LayoutNotifier extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  set pageIndex(int index) {
    var server = globalFunction.getServer();
    if (server == null) {
      _pageIndex = 4;
    } else {
      Future checkToken = globalFunction.check();
      checkToken.then(
        (value) {
          if (value) {
            if (index == 4 || index == 5 || index == 6) {
              _pageIndex = 7;
            } else {
              _pageIndex = index;
            }
          } else {
            // setToken('');
            if (index == 0 ||
                index == 1 ||
                index == 2 ||
                index == 5 ||
                index == 6) {
              _pageIndex = index;
            } else {
              _pageIndex = 4;
            }
          }
          notifyListeners();
        },
      );
    }
  }
}
