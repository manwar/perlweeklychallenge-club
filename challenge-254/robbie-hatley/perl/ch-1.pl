#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 254-1.
Written by Robbie Hatley on Sun Jan 28, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 254-1: Three Power
Submitted by: Mohammad S Anwar
You are given a positive integer, $n. Write a script to return
true if the given integer is a power of three otherwise return
false.

Example 1:
Input: $n = 27
Output: true
27 = 3 ^ 3

Example 2:
Input: $n = 0
Output: true
0 = 0 ^ 3

Example 3:
Input: $n = 6
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
First of all, I had to think hard whether "Three Power" means "x^3" or "3^x". But the latter would be
"3 to the x power", whereas the former is "x to the 3 power", so I think "Three Power" means "x^3".

This is also corroborated by Example #2, which states that 0 is a "Three Power" because "0 = 0^3",
not "0 = 3^0" which is false (3^0 = 1). So this problem boils down to "Given an integer x, does there exist
an integer r such that r^3 = x?"

There are many ways to solve this problem: Factoring, trial-and-error, subtracting integer portion of cube
root from cube root, cubing the integer portion of the cube root, etc.

I initially chose to use a method that's simpler than any of those: If the cube root of $x is an integer,
then $x is a perfect cube, else it isn't.

However, I ran into a complicating factor with that approach: C (and hence Perl) fails to correctly implement
a**b if a is a negative real number and b is 1/n where n is an odd integer greater than 1 (3, 5, 7...).

So I changed my approach to the following: I first calculate the icr (integer portion of cube root) of x.
Then I check to see if icr(x)^3 is equal to x. If it is, $x is a perfect cube, else it's not.

With that in-mind, I created these subs:

# Return the integer portion of the cube root of any integer:
sub icr ($x) {
   my $r = 0;
   if ($x < 0) {--$r until ($r-1)*($r-1)*($r-1) < $x}
   else        {++$r until ($r+1)*($r+1)*($r+1) > $x}
   return $r;
}

# Is a given integer a perfect cube?
sub is_cube ($x) {
   return icr($x)*icr($x)*icr($x) == $x;
}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of integers in proper Perl syntax, like so:
./ch-1.pl '(-28, -27, -26, -9, -8, -7, -1, 0, 1, 7, 8, 9, 26, 27, 28)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Is a given string a decimal representation of an integer?
sub is_int ($x) {
   return $x =~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/;
}

# Return the integer portion of the cube root of any integer:
sub icr ($x) {
   my $r = 0;
   if ($x < 0) {--$r until ($r-1)*($r-1)*($r-1) < $x}
   else        {++$r until ($r+1)*($r+1)*($r+1) > $x}
   return $r;
}

# Is a given integer a perfect cube?
sub is_cube ($x) {
   return icr($x)*icr($x)*icr($x) == $x;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @ints = @ARGV ? eval($ARGV[0]) : (27, 0, 6);

# Main loop:
for my $int (@ints) {
   !is_int($int) and say "Error: $int is not an integer" and next;
   is_cube($int) and say "$int is a perfect cube."
                 or  say "$int is NOT a perfect cube.";
}
exit;
