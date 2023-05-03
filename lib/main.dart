import 'package:activity_tracker/styles/app_theme.dart';
import 'package:activity_tracker/routes.dart';
import 'package:activity_tracker/widgets/unfocus.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: AppTheme.data(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => BotToastInit()(
        context,
        Unfocus(
          child: child!,
        ),
      ),
    );
  }
}
