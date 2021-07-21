class Currency {
  Map<int, String> get _suffixMap => const {0: "", 1: "K", 2: "M", 3: "B"};

  String shortCurrency({double value = 0}) {
    var count = 0;
    double i;

    for (i = value; i >= 1000; i /= 1000, ++count) {}

    return (i % 1 == 0 ? i.toInt().toString() : i.toStringAsFixed(2)) +
        _suffixMap[count]!;
  }
}
