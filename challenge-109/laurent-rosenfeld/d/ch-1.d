import std.stdio;

int chowla(int n) {
    int sum = 0;
    for (int i = 2; i <= n-1; i++) {
        if (n % i == 0) {
            sum += i;
        }
    }
    return sum;
}
void main() {
    for (int n = 1; n <= 37; n++) {
        writef("%d ", chowla(n));
    }
    writeln("");
}
