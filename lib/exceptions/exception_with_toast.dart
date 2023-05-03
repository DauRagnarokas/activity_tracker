class ExceptionWithToast implements Exception {
  final String message;

  ExceptionWithToast(this.message);

  @override
  String toString() {
    return message;
  }
}
