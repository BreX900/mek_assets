class StateException implements Exception {
  final String message;

  StateException(this.message);

  @override
  String toString() => message;
}
