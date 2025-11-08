extension WaitAllOrThrowFirst<T> on Iterable<Future<T>> {
  Future<List<T>> get waitOrThrowFirst => Future.wait(this);
}
