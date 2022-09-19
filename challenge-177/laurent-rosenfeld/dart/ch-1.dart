import "dart:io";

var damm = [ "0317598642",
             "7092154863",
             "4206871359",
             "1750983426",
             "6123045978",
             "3674209581",
             "5869720134",
             "8945362017",
             "9438617205",
             "2581436790" ];

void main() {
    print("Valid numbers between 5700 and 5800 are:");
    for (int i = 5700; i <= 5800; i++ ) {
        if (is_valid(i)) {
            stdout.write("$i ");
        }
    }
    stdout.write("\n");
}
bool is_valid(n) {
    var digits = n.toString().split("");
    int temp = 0;
    var len = digits.length;
    for (int i = 0; i < len; i++) {
        var row = damm[temp];
        var idx = int.parse(digits[i]);
        temp = int.parse(row[idx]);
    }
    return temp == 0;
}
