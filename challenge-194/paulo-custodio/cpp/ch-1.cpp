/*
Challenge 194

Task 1: Digital Clock
Submitted by: Mohammad S Anwar
You are given time in the format hh:mm with one missing digit.

Write a script to find the highest digit between 0-9 that makes it valid time.

Example 1
Input: $time = '?5:00'
Output: 1

Since 05:00 and 15:00 are valid time and no other digits can fit in the missing place.
Example 2
Input: $time = '?3:00'
Output: 2
Example 3
Input: $time = '1?:00'
Output: 9
Example 4
Input: $time = '2?:00'
Output: 3
Example 5
Input: $time = '12:?5'
Output: 5
Example 6
Input: $time =  '12:5?'
Output: 9
*/

#include <iostream>
#include <string>

int missing_digit(const std::string& clock) {
    if (clock.size()!=5) return -1;
    if (clock[0]=='?' && clock[1]<='3') return 2;
    if (clock[0]=='?') return 1;
    if (clock[0]<='1' && clock[1]=='?') return 9;
    if (clock[1]=='?') return 3;
    if (clock[3]=='?') return 5;
    if (clock[4]=='?') return 9;
    return -1;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 1) {
        std::cerr << "usage: ch-1 hh:mm" << std::endl;
        return EXIT_FAILURE;
    }

    std::cout << missing_digit(argv[0]) << std::endl;
}
