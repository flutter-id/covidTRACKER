import 'package:flutter/material.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';
import 'package:lancong/constants/style_constant.dart';
import 'package:lancong/modules/login/login_notifier.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool statusLogin = false;

  @override
  Widget build(BuildContext context) {
    final LoginNotifier loginNotifier = Provider.of<LoginNotifier>(context);
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
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Text(
                          'LOGIN',
                          style: mTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(loginNotifier.loginStatus.toString()),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email ID',
                            style: mTitleStyle,
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'example@domain.tld',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          loginNotifier.errorEmail,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: mTitleStyle,
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'password',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          loginNotifier.errorPassword,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          loginNotifier.errorUndefined,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.center,
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
                            Future status = loginNotifier.login(
                              emailController.text,
                              passwordController.text,
                            );
                            status.then((result) {
                              if (result) {
                                layoutNotifier.pageIndex = 0;
                              } else {
                                layoutNotifier.pageIndex = 5;
                              }
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
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forget Password?',
                          style: mTitleStyle,
                        ),
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
