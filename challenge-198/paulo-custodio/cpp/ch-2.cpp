/*
Challenge 198

Task 2: Prime Count
Submitted by: Mohammad S Anwar
You are given an integer $n > 0.

Write a script to print the count of primes less than $n.

Example 1
Input: $n = 10
Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.
Example 2
Input: $n = 15
Output: 6
Example 3
Input: $n = 1
Output: 0
Example 4
Input: $n = 25
Output: 9
*/

#include <iostream>

// https://en.wikipedia.org/wiki/Primality_test
bool is_prime(int n) {
    if (n==2 || n==3) return true;
    if (n<=1 || n%2==0 || n%3==0) return false;
    for (int i=5; i*i<=n; i+=6)
        if (n%i==0 || n%(i+2)==0) return false;
    return true;
}

int next_prime(int p) {
    p++;
    while (!is_prime(p)) p++;
    return p;
}

int count_primes_below_n(int n) {
    int count=0;
    int p=2;
    while (p<n) {
        count++;
        p=next_prime(p);
    }
    return count;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc!=1) {
        std::cerr << "usage: ch-2 n" << std::endl;
        return EXIT_FAILURE;
    }

    int n=atoi(argv[0]);
    int count=count_primes_below_n(n);
    std::cout << count << std::endl;
}
