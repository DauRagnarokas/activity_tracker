import 'package:activity_tracker/models/activity.dart';
import 'package:activity_tracker/routes.dart';
import 'package:activity_tracker/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/activity_prop.dart';
import '../models/popup_menu_item.dart';
import '../providers/activities_provider.dart';
import '../templates/main.dart';
import '../misc/toast.dart';

class ActivityScreen extends HookConsumerWidget {
  final String id;

  const ActivityScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Activity activity = ref.watch(activitiesProvider).firstWhere(
          (element) => element.key == id,
        );
    final List<PopupItem> popupItems = useMemoized(() => [
          PopupItem(
            text: 'Edit',
            iconData: Icons.edit,
            onPressed: () => context.go(
              Routes.activityEdit(key: activity.key),
            ),
          ),
          PopupItem(
              text: 'Delete',
              iconData: Icons.delete,
              isDanger: true,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return DialogWidget(
                        title: 'Are you sure you want to delete the item?',
                        cancelButton: ButtonProps(
                          label: 'Cancel',
                          onPressed: ctx.pop,
                        ),
                        actionButton: ButtonProps(
                          label: 'Delete',
                          onPressed: () {
                            ref
                                .read(activitiesProvider.notifier)
                                .remove(activity);
                            Toast.success('The activity was deleted.');
                            context.go(Routes.home);
                          },
                        ),
                      );
                    });
              }),
        ]);
    return MainTemplate(
      title: 'Activity',
      action: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) {
              return SafeArea(
                top: false,
                left: false,
                right: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      popupItems.length,
                      (index) => PopupMenuItem(
                        value: index,
                        child: ListTile(
                          leading: Icon(
                            popupItems[index].iconData,
                            color: popupItems[index].isDanger
                                ? Theme.of(context)
                                    .colorScheme
                                    .error
                                    .withOpacity(0.7)
                                : null,
                          ),
                          title: Text(
                            popupItems[index].text,
                            style: TextStyle(
                              color: popupItems[index].isDanger
                                  ? Theme.of(context).colorScheme.error
                                  : null,
                            ),
                          ),
                          onTap: () {
                            context.pop();
                            popupItems[index].onPressed?.call();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      child: _buildActivityDataView(activity, context),
    );
  }

  _buildActivityDataView(Activity activity, BuildContext context) {
    final List<ActivityProp> props = activity
        .toJson()
        .entries
        .map(
          (e) => ActivityProp(name: e.key, value: e.value.toString()),
        )
        .toList();
    return Container(
      alignment: const Alignment(0, -0.3),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(125),
        },
        children: [
          for (int index = 0; index < props.length; index++)
            if (props[index].value.isNotEmpty)
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      props[index].nameCapitalized,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Text(
                    props[index].value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
