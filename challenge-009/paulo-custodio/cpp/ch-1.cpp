/*
Challenge 009

Challenge #1
Write a script that finds the first square number that has at least 5 distinct
digits.This was proposed by Laurent Rosenfeld.
*/

#include <iostream>
using namespace std;

int num_diff_digits(int n) {
    bool digits[10] = {0};
    int count = 0;
    while (n > 0) {
        int digit = n % 10;
        n /= 10;
        if (!digits[digit]) {
            digits[digit] = true;
            count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    int num = 0;
    if (argc == 2)
        num = atoi(argv[1]);
    if (num == 0)
        num = 5;

    int n = 1;
    while (num_diff_digits(n * n) < num)
        n++;
    cout << n * n << endl;
}
