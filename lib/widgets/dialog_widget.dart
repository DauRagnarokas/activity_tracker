import 'package:activity_tracker/widgets/sized_spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonProps {
  final String label;
  final VoidCallback onPressed;

  ButtonProps({required this.label, required this.onPressed});
}

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {super.key,
      required this.cancelButton,
      required this.actionButton,
      required this.title});

  final ButtonProps cancelButton;
  final ButtonProps actionButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 200),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTitle(context),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: cancelButton.onPressed,
                          child: Text(
                            cancelButton.label,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedSpacer.horizontal(),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: actionButton.onPressed,
                            child: Text(
                              actionButton.label,
                              textAlign: TextAlign.center,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                tooltip: 'Close',
                icon: const Icon(
                  Icons.close,
                ),
                onPressed: context.pop,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
