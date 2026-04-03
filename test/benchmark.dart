void main() {
  final stopwatch = Stopwatch();
  const iterations = 10000000;

  // Baseline
  stopwatch.start();
  for (var i = 0; i < iterations; i++) {
    int days = 31;
    List<int> listdates = List<int>.generate(days, (index) => index + 1);
  }
  stopwatch.stop();
  final baselineTime = stopwatch.elapsedMilliseconds;
  print('Baseline (always generate): ${baselineTime}ms');

  // Optimized
  stopwatch.reset();
  stopwatch.start();
  List<int> listdates = List<int>.generate(31, (index) => index + 1);
  for (var i = 0; i < iterations; i++) {
    int days = 31;
    if (listdates.length != days) {
      listdates = List<int>.generate(days, (index) => index + 1);
    }
  }
  stopwatch.stop();
  final optimizedTime = stopwatch.elapsedMilliseconds;
  print('Optimized (check before generate): ${optimizedTime}ms');

  if (optimizedTime < baselineTime) {
    print(
      'Improvement: ${((baselineTime - optimizedTime) / baselineTime * 100).toStringAsFixed(2)}%',
    );
  } else {
    print('No improvement detected in this micro-benchmark.');
  }
}
