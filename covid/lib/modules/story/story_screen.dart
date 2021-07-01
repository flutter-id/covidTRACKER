import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'story_widget.dart';
import 'story_notifier.dart';

class StoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StoryNotifier>.value(
          value: StoryNotifier(),
        )
      ],
      child: StoryWidget(),
    );
  }
}
