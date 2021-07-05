/*
Challenge 116

TASK #2 - Sum of Squares
Submitted by: Mohammad Meraj Zia
You are given a number $N >= 10.

Write a script to find out if the given number $N is such that sum of squares
of all digits is a perfect square. Print 1 if it is otherwise 0.

Example
Input: $N = 34
Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2

Input: $N = 50
Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2

Input: $N = 52
Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
*/

#include <iostream>
#include <cmath>
using namespace std;

bool sum_of_squares_is_perfect_square(int num) {
    if (num < 10) return false;

    double sum = 0;
    while (num > 0) {
        int digit = num % 10;
        num /= 10;
        sum += digit*digit;
    }

    double sqrt_int = floor(sqrt(sum));
    if (sqrt_int*sqrt_int == sum)
        return true;
    else
        return false;
}

int main(int argc, char* argv[]) {
    int n = 0;
    if (argc == 2) n = atoi(argv[1]);
    cout << (sum_of_squares_is_perfect_square(n) ? 1 : 0) << endl;
}
