import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String getErrorMessage(Object error) {
  if (error is DioError) {
    return error.message ?? '';
  } else {
    return error.toString();
  }
}

class ErrorHandler extends StatelessWidget {
  ErrorHandler(
    this.error,
    this.stackTrace, {
    super.key,
    this.isSliver = false,
    this.showMessage = true,
  }) {
    message = getErrorMessage(error);
  }

  final Object error;
  final StackTrace stackTrace;
  final bool isSliver;
  final bool showMessage;
  late final String message;

  @override
  Widget build(BuildContext context) {
    debugPrint('ERROR: $message\n$stackTrace');
    return isSliver
        ? SliverToBoxAdapter(child: _buildMessageView(context))
        : _buildMessageView(context);
  }

  Widget _buildMessageView(BuildContext context) {
    if (!showMessage) return const SizedBox.shrink();
    return Center(
      child: Text(
        message.toString(),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
