import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lancong/constants/color_constant.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lancong/modules/layout/elements/bottom_navigation_widget.dart';
import 'package:lancong/modules/home/home_screen.dart';
import 'package:lancong/modules/status/status_screen.dart';
import 'package:lancong/modules/graph/graph_screen.dart';
import 'package:lancong/modules/story/story_screen.dart';
import 'package:lancong/modules/account/account_screen.dart';
import 'package:lancong/modules/login/login_screen.dart';
import 'package:lancong/modules/register/register_screen.dart';
import 'package:lancong/modules/profile/profile_screen.dart';
import 'package:lancong/modules/status_form/status_form_screen.dart';
import 'package:lancong/modules/story_form/story_form_screen.dart';

class LayoutWidget extends StatefulWidget {
  @override
  _LayoutWidgetState createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  var bottomTextStyle =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), //index 0
    StoryScreen(), //index 1
    GraphScreen(), //index 2
    StatusScreen(), //index 3
    AccountScreen(), //index 4
    LoginScreen(), //index 5
    RegisterScreen(), //index 6
    ProfileScreen(), //index 7
    StatusFormScreen(), //index 8
    StoryFormScreen(), //index 9
  ];

  @override
  Widget build(BuildContext context) {
    final LayoutNotifier layoutNotifier = Provider.of<LayoutNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mBackgroundColor,
        title: SvgPicture.asset('assets/svg/covidTRACKER.svg'),
        elevation: 0,
      ),
      backgroundColor: mBackgroundColor,
      bottomNavigationBar: Container(
          height: 64,
          decoration: BoxDecoration(
            color: mFillColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          child: BottomNavigationWidget()),
      body: _widgetOptions.elementAt(layoutNotifier.pageIndex),
    );
  }
}
