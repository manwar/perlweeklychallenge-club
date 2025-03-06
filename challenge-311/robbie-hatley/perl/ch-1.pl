#!/usr/bin/env -S perl -C63
y/[a-zA-Z]/[A-Za-z]/,print while <>;

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 311-1,
written by Robbie Hatley on Wed Mar 05, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 311-1: Upper Lower
Submitted by: Mohammad Sajid Anwar
You are given a string consisting of english letters only. Write
a script to convert lower case to upper and upper case to lower
in the given string.

Example #1:
Input: $str = "pERl"
Output: "PerL"

Example #2:
Input: $str = "rakU"
Output: "RAKu"

Example #3:
Input: $str = "PyThOn"
Output: "pYtHoN"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This can be easily done with a one-liner using Perl's "transpose" operator, "tr", aka "y":
y/[a-zA-Z]/[A-Za-z]/,print while <>

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is from STDIN and can consist of any number of Unicode UTF-8 strings of any lengths.

Output is to STDOUT and will be a version of the input with the cases of the English letters reversed.

Example using a pipe:
echo -ne "pERl rakU PyThOn\n" | ./ch-1.pl
which would produce this output:
PerL RAKu pYtHoN

Example using direct keyboard input:
./ch-1.pl
(Then type lines of text on command line, ending each line with Enter and ending input with Ctrl-d.)

=cut
