import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account_widget.dart';
import 'account_notifier.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AccountNotifier>.value(
          value: AccountNotifier(),
        )
      ],
      child: AccountWidget(),
    );
  }
}
