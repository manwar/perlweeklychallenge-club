void main(List<String> args) {
  const tStr =
      "0317598642709215486342068713591750983426612304597836742095815869720134894536201794386172052581436790";
  var guide = "please provide a positive number";
  if (args.length < 1 || int.tryParse(args[0]) == null) {
    print(guide);
  } else {
    int pos = 0;
    for (var col in args[0].split("").map((n) => int.parse(n))) {
      //print(col);
      pos = pos * 10 + col;
      pos = int.parse(tStr.substring(pos, pos + 1));
      //print(pos);
    }
    print("Input: n = ${args[0]}\nOutput: ${(pos == 0).toString()}");
  }
}
