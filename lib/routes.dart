import 'package:activity_tracker/screens/activity_screen.dart';
import 'package:activity_tracker/screens/add_activity_screen.dart';
import 'package:activity_tracker/screens/edit_activity_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';

class Routes {
  static const String home = '/';
  static String activity({required String key}) => '/activity/$key';
  static String activityEdit({required String key}) => '/activity/$key/edit';
  static const String activityAdd = '/activity/new';
}

final GoRouter router = GoRouter(
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'activity/new',
          builder: (context, state) => const AddActivityScreen(),
        ),
        GoRoute(
            path: 'activity/:id',
            builder: (context, state) =>
                ActivityScreen(id: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) =>
                    EditActivityScreen(id: state.pathParameters['id']!),
              ),
            ]),
      ],
    ),
  ],
);
