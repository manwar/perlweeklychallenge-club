/*
Challenge 021

Task #1
Write a script to calculate the value of e, also known as Euler's number and
Napier's constant. Please checkout wiki page for more information.
*/

#include <stdio.h>

double calc_e() {
    double e = 1.0;
    double n = 0.0;
    double prod = 1.0;
    double prev = 0.0;
    while (prev != e) {
        prev = e;
        prod *= ++n;
        e += 1/prod;
    }
    return e;
}

int main() {
    printf("%.14f\n", calc_e());
}
