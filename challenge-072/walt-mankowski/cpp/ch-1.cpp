#include <stdlib.h>
#include <iostream>
#include <string>

using namespace std;

const unsigned long long fact(const int n) {
    unsigned long long res = 1;
    for (int i = 2; i <= n; i++)
        res *= i;
    return res;
}

const int num_trailing_zeros(const unsigned long long n) {
    int cnt = 0;
    unsigned long long pwr = 10;
    while (n % pwr == 0) {
        cnt++;
        pwr *= 10;
    }
    return cnt;
}

int main(int argc, char *argv[]) {
    int n = atoi(argv[1]);
    unsigned long long f = fact(n);
    int z = num_trailing_zeros(f);
    string zeros = (z == 1) ? "zero" : "zeros";
    cout << n << " as N! = " << f << " has " << z << " trailing " << zeros << endl;
}
