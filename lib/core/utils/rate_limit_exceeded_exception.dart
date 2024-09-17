class RateLimitExceededException implements Exception {
  final int waitTimeInSeconds;

  RateLimitExceededException(this.waitTimeInSeconds);

  @override
  String toString() =>
      'Rate limit exceeded. Try again in $waitTimeInSeconds seconds.';
}
