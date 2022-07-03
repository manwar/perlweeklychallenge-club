import "dart:io";
void main() {
    var count = 0;
    var j = 1;
    while (count < 20) {
        if (is_abundant(j)) {
            stdout.write("$j ");
            count++;
        }
        j += 2;
    }
}

bool is_abundant(n) {
    var sum = 0;
    for (int i = 1; i <= n/2; i++) {
        if (n % i == 0) {
            sum += i;
            if (sum > n) {
                return true;
            }
        }
    }
    return false;
}
