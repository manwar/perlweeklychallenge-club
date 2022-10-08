import "dart:math";

void main(List<String> args) {
  if (args.isEmpty) {
    var xCase = Random().nextInt(2);
    switch (xCase) {
      case 0:
        args = ['ab-cde-123', '123.abc.420', '3abc-0010.xy'];
        break;
      case 1:
        args = ['1234567.a', 'a-1234-bc', 'a.b.c.d.e.f'];
        break;
    }
  }
  print(
      'Input: ${args.map((arg) => "'$arg'")}\nOutput: ${args.map((arg) => mask(arg, "x", 4))}\n');
}

String mask(String str, mask, int count) {
  final RegExp exp = RegExp(r'([\W_A-Z]*)([a-f0-9])');
  var res = "";
  for (var m in exp.allMatches(str)) {
    res += '${count > 0 ? "${m.groups([1, 2]).first}$mask" : m[0]}';
    count--;
  }
  return "'$res'";
}
