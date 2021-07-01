import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:covidtracker/modules/layout/layout_notifier.dart';
import 'package:covidtracker/constants/color_constant.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key key}) : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;
  SvgPicture widgetIcon = new SvgPicture.asset('assets/icons/home_colored.svg');

  @override
  Widget build(BuildContext context) {
    final LayoutNotifier layoutNotifier = Provider.of<LayoutNotifier>(context);

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _selectedIndex == 0
              ? new SvgPicture.asset('assets/icons/home_colored.svg')
              : new SvgPicture.asset('assets/icons/home.svg'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1
              ? new SvgPicture.asset('assets/icons/account_colored.svg')
              : new SvgPicture.asset('assets/icons/account.svg'),
          label: 'Story',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2
              ? new SvgPicture.asset('assets/icons/watch_colored.svg')
              : new SvgPicture.asset('assets/icons/watch.svg'),
          label: 'Graph',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 3
              ? new SvgPicture.asset('assets/icons/order_colored.svg')
              : new SvgPicture.asset('assets/icons/order.svg'),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 4
              ? new SvgPicture.asset('assets/icons/account_colored.svg')
              : new SvgPicture.asset('assets/icons/account.svg'),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: mBlueColor,
      unselectedItemColor: mSubtitleColor,
      // onTap: _onItemTapped,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        layoutNotifier.pageIndex = index;
      },
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      showUnselectedLabels: true,
      elevation: 0,
    );
  }
}
