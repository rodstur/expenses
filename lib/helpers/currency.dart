class Currency {
  final double _value;

  const Currency(this._value);

  Map<int, String> get _suffixMap => const {0: "", 1: "K", 2: "M", 3: "B"};

  String get shortCurrency {
    int count = 0;
    dynamic newValue = _value;

    while (newValue as double >= 1000) {
      newValue /= 1000;
      count++;
    }

    return (newValue % 1 == 0)
        ? newValue.toInt().toString()
        : "${newValue.toStringAsFixed(2)}${_suffixMap[count]}";
  }
}
