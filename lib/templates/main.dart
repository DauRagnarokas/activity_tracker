import 'package:activity_tracker/constants/constants.dart';
import 'package:flutter/material.dart';

class MainTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? floatingActionButton;
  final Widget? action;

  const MainTemplate({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: action != null ? [action!] : null,
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Container(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: kMobileMaxWidth),
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
