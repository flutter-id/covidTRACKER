import 'package:flutter/material.dart';
import 'package:lancong/constants/style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  TextEditingController serverController = TextEditingController();

  String server = '192.168.1.2:8000';
  setServer(String server) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('server', server);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Server Connection Saved',
          style: mTitleStyle,
        ),
        content: Text(
          'Your server connection has been saved successfully',
        ),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text('Cancel'),
          // ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LayoutNotifier layoutNotifier = Provider.of<LayoutNotifier>(context);
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'ACCOUNT',
                          style: mTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Server Connection',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: serverController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: '192.168.1.2:8000',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            'Connect Server',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            setState(() {
                              setServer(serverController.text);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            side: BorderSide(width: 2, color: Colors.white),
                            primary: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            'Login',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            layoutNotifier.pageIndex = 5;
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              side: BorderSide(width: 2, color: Colors.blue),
                              primary: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            'Register Now',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            layoutNotifier.pageIndex = 6;
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              side: BorderSide(width: 2, color: Colors.blue),
                              primary: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
