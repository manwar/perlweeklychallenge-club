void main(List<String> args) {
  if (args.isEmpty) {
    args = ['1ac2.34f0.b1c2', 'abc1.20f1.345a'];
  }
  for (String mac in args) {
    print(
        "Input: $mac\nOutput: ${isValid(mac) ? convert(mac) : "invalid input"}\n");
  }
}

bool isValid(String str) {
  return RegExp(r'^[a-f0-9]{4}\.[a-f0-9]{4}\.[a-f0-9]{4}$').hasMatch(str);
}

String convert(String str) {
  return RegExp(r'([a-f0-9]{2})')
      .allMatches(str)
      .map((m) => m[0].toString())
      .join(":");
}
