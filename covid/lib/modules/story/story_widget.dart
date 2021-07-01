import 'package:flutter/material.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';
import 'package:lancong/constants/style_constant.dart';
// import 'package:lancong/modules/story/story_notifier.dart';
import 'package:provider/provider.dart';
import 'package:lancong/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lancong/modules/story/elements/story_list_widget.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({Key key}) : super(key: key);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool storyLogin = false;

  getStory() async {
    // var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    if (server == null) {
      return null;
    } else {
      var url = Uri.http(server, '/api/post');
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json"
          // 'Authorization': 'Bearer $token',
        },
      );
      var result = json.decode(response.body);
      print(result);
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
    // final StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context);
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
                              return StoryListWidget(
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
                          future: getStory(),
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
                            'Add Story',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            layoutNotifier.pageIndex = 9;
                            // Future story = storyNotifier.login(
                            //   emailController.text,
                            //   passwordController.text,
                            // );
                            // story.then((result) {
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
