import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_widget.dart';
import 'profile_notifier.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileNotifier>.value(
          value: ProfileNotifier(),
        )
      ],
      child: ProfileWidget(),
    );
  }
}
