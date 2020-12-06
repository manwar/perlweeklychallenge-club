// To run:
// $ dart ch-1.dart 100
// 13015

void main(List<String> args) {
    var n = 3;
    if (args.length == 1)
        n = int.parse(args[0]);

    var s = 0;
    for (var x = 1; x <= n; x++) {
        for (var y = x + 1; y <= n; y++) {
            s += x.gcd(y);
        }
    }

    print(s);
}
