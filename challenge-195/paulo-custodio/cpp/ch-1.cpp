/*
Challenge 195

Task 1: Special Integers
Submitted by: Mohammad S Anwar
You are given a positive integer, $n > 0.

Write a script to print the count of all special integers between 1 and $n.

An integer is special when all of its digits are unique.

Example 1:
Input: $n = 15
Output: 14 as except 11 all other integers between 1 and 15 are spcial.
Example 2:
Input: $n = 35
Output: 32 as except 11, 22, 33 all others are special.
*/

#include <iostream>

bool is_special_int(int n) {
    bool digits[10]={0};
    while (n>0) {
        int digit=n%10;
        n/=10;
        if (digits[digit])
            return false;
        digits[digit]=true;
    }
    return true;
}

int count_special_ints(int n) {
    int count=0;
    for (int i=1; i<=n; i++)
        if (is_special_int(i))
            count++;
    return count;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 1) {
        std::cerr<<"usage: ch-1 n"<<std::endl;
        return EXIT_FAILURE;
    }

    int n=atoi(argv[0]);
    std::cout<<count_special_ints(n)<<std::endl;
}
