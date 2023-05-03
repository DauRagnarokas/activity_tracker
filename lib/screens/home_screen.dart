import 'package:activity_tracker/models/activity.dart';
import 'package:activity_tracker/routes.dart';
import 'package:activity_tracker/widgets/sized_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/activities_provider.dart';
import '../templates/main.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Activity> activities = ref.watch(activitiesProvider).toList();
    return MainTemplate(
      title: 'Activities',
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(Routes.activityAdd),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      child: activities.isNotEmpty
          ? ListView.separated(
              itemCount: activities.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  context.go(
                    Routes.activity(key: activities[index].key),
                  );
                },
                title: Text(activities[index].activity),
                subtitle: Text(activities[index].type),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
            )
          : Center(
              key: const Key('no_activities'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/empty_state.svg',
                    height: 125,
                  ),
                  const SizedSpacer.vertical(),
                  Text(
                    'No Activities'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
    );
  }
}
