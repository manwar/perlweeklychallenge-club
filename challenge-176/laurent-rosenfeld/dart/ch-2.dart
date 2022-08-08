import "dart:io";

void main() {
    for (int i = 0; i <= 100; i++ ) {
        if (is_reversible(i)) {
            stdout.write("$i ");
        }
    }
}

bool is_reversible(n) {
    var rev = int.parse(n.toString().split("").reversed.join(""));
    var digits = (n + rev).toString().split("");
    int len = digits.length;
    for (int i = 0; i < len; i++) {
        if (int.parse(digits[i]) % 2 == 0) {
            return false;
        }
    }
    return true;
}
