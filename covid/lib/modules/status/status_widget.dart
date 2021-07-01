import 'package:flutter/material.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';
import 'package:lancong/constants/style_constant.dart';
import 'package:provider/provider.dart';
import 'package:lancong/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lancong/modules/status/elements/status_list_widget.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({Key key}) : super(key: key);

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool statusLogin = false;

  getStatus() async {
    var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    if (server == null) {
      return null;
    } else {
      var url = Uri.http(server, '/api/status');
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else {
        print(result['message'].toString());
      }
    }
  }

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final StatusNotifier statusNotifier = Provider.of<StatusNotifier>(context);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 225,
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            if (snapshot.hasData) {
                              return StatusListWidget(
                                list: snapshot.data['data'],
                              );
                            } else {
                              return SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                          future: getStatus(),
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
                            'Add Status',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            layoutNotifier.pageIndex = 8;
                            // Future status = statusNotifier.login(
                            //   emailController.text,
                            //   passwordController.text,
                            // );
                            // status.then((result) {
                            //   if (result) {
                            //     layoutNotifier.pageIndex = 0;
                            //   } else {
                            //     layoutNotifier.pageIndex = 5;
                            //   }
                            // });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            side: BorderSide(width: 2, color: Colors.white),
                            primary: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
