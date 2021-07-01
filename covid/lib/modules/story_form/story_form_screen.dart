import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'story_form_widget.dart';
import 'story_form_notifier.dart';

class StoryFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StoryFormNotifier>.value(
          value: StoryFormNotifier(),
        )
      ],
      child: StoryFormWidget(),
    );
  }
}
