/*
Challenge 115

TASK #2 - Largest Multiple
Submitted by: Mohammad S Anwar
You are given a list of positive integers (0-9), single digit.

Write a script to find the largest multiple of 2 that can be formed from the
list.

Examples
Input: @N = (1, 0, 2, 6)
Output: 6210

Input: @N = (1, 4, 2, 8)
Output: 8412

Input: @N = (4, 1, 7, 6)
Output: 7614
*/

import std.stdio;
import std.conv;
import std.algorithm.mutation : remove;
import std.algorithm.sorting : sort;

int largest_even(int[] nums) {
    // smallest even number is last digit
    int last_digit = 10;
    foreach (int num; nums) {
        if ((num % 2) == 0 && num < last_digit)
            last_digit = num;
    }
    if (last_digit == 10) return 0;

    // remove last_digit from list
    nums = remove!(a => a == last_digit)(nums);

    // sort remaining digits in descending order
    nums.sort!("a > b");

    int result = 0;
    foreach (int num; nums)
        result = result * 10 + num;
    result = result * 10 + last_digit;

    return result;
}

void main(string[] args) {
    int[] nums;
    foreach (string arg; args[1..$])
        nums ~= to!int(arg);
    writeln(largest_even(nums));
}
