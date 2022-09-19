import std.stdio;

int is_abundant(int n) {
    int sum = 0;
    for (int i = 2; i <= n/2; i++) {
        if (n % i == 0) {
            sum += i;
            if (sum > n) {
                return 1;
            }
        }
    }
    return 0;
}

void main() {
    int n = 1;
    int count = 0;
    while (count < 20) {
        if (is_abundant(n)) {
            printf("%d ", n);
            count ++;
        }
        n += 2;
    }
}
