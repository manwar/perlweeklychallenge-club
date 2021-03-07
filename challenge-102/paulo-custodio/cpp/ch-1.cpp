/*
Challenge 102

TASK #1 › Rare Numbers
Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to generate all Rare numbers of size $N if exists. Please
checkout the page for more information about it.
Examples

(a) 2 digits: 65
(b) 6 digits: 621770
(c) 9 digits: 281089082
*/

#include <iostream>
#include <cmath>

int ipow(int base, int exp) {
    int result = 1;
    for (;;) {
        if (exp & 1)
            result *= base;
        exp >>= 1;
        if (!exp)
            break;
        base *= base;
    }
    return result;
}

int invert_number(int r) {
    int r1 = 0;
    while (r != 0) {
        r1 = r1 * 10 + (r % 10);
        r = r / 10;
    }
    return r1;
}

bool is_perfect_square(int n) {
    double s = sqrt((double)n);
    if (floor(s) == s)
        return true;
    else
        return false;
}

void print_rare(int n) {
    int start = ipow(10, n - 1);
    int end = ipow(10, n );
    for (int r = start; r < end; r++) {
        int r1 = invert_number(r);
        if (is_perfect_square(r + r1) && r >= r1 && is_perfect_square(r - r1))
            std::cout << r << std::endl;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: ch-1 N" << std::endl;
        return EXIT_FAILURE;
    }
    else
        print_rare(atoi(argv[1]));
}
