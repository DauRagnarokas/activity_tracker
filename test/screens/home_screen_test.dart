import 'package:activity_tracker/screens/add_activity_screen.dart';
import 'package:activity_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../extensions.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  testWidgets('override repositoryProvider', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: const [
          // repositoryProvider.overrideWithValue(FakeRepository())
        ],
        // Our application, which will read from todoListProvider to display the todo-list.
        // You may extract this into a MyApp widget
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(builder: (context, ref, _) {
              return const HomeScreen();
            }),
          ),
        ),
      ),
    );

    expect(find.text('Activities'), findsOneWidget);
    expect(find.byKey(const Key('no_activities')), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('pushes SettingsPage when TextButton is tapped', (tester) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpRealRouterApp(
      (child) => Consumer(builder: (context, ref, _) {
        return const HomeScreen();
      }),
    );

    final Finder element = find.byType(FloatingActionButton);
    await tester.tap(element);

    expect(element, findsOneWidget);
    await tester.tap(element);
    await tester.pumpAndSettle();

    verify(() => mockObserver.didPush(any(), any()));

    expect(find.byType(AddActivityScreen), findsOneWidget);
  });
}
