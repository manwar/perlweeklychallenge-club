/*
Challenge 007

Challenge #1
Print all the niven numbers from 0 to 50 inclusive, each on their own line.
A niven number is a non-negative number that is divisible by the sum of its
digits.
*/

#include <cassert>
#include <iostream>
using namespace std;

bool is_niven(int n) {
    assert(n > 0);
    int sum = 0;
    int rem = n;
    while (rem > 0) {
        int digit = rem % 10;
        rem /= 10;
        sum += digit;
    }
    if (n % sum == 0)
        return true;
    else
        return false;
}

int main(int argc, char* argv[]) {
    int max = 50;
    if (argc == 2) max = atoi(argv[1]);
    if (max < 1) return EXIT_FAILURE;
    for (int n = 1; n <= max; n++)
        if (is_niven(n))
            cout << n << endl;
    return EXIT_SUCCESS;
}
