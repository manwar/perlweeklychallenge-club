#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 311-2,
written by Robbie Hatley on Wed Mar 05, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 311-2: Group Digit Sum
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, made up of digits, and an integer,
$int, which is less than the length of the given string. Write a
script to divide the given string into consecutive groups of
size $int (plus one for leftovers if any). Then sum the digits
of each group, and concatenate all group sums to create a new
string. If the length of the new string is less than or equal to
the given integer then return the new string, otherwise continue
the process.

Example 1
Input: $str = "111122333", $int = 3
Output: "359"
Step 1: "111", "122", "333" => "359"

Example 2
Input: $str = "1222312", $int = 2
Output: "76"
Step 1: "12", "22", "31", "2" => "3442"
Step 2: "34", "42" => "76"

Example 3
Input: $str = "100012121001", $int = 4
Output: "162"
Step 1: "1000", "1212", "1001" => "162"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The "...otherwise continue the process" in the Problem Description is a big clue that recursion will be useful
here, so I'll make a recursive subroutine that performs the described summing and concatenation steps, then
"continues the process" (by recursing) until the length of the string is no more than the given integer.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is from internal array or @ARGV. If using @ARGV, please provide one command-line argument, which should
be a 'single-quoted' array of arrays in proper Perl syntax, with each inner array containing a string of
digits in "double quotes" followed by an integer which is less than the length of the string of digits.

For example:
./ch-2.pl '(["2940673", 3], ["305846253401", 4], ["00000000000", 5])'

Output is to STDOUT and will be a each string/integer pair followed by a version of the string which has been
"condensed" by repeatedly summing groups and concatenating until the length of the string is no greater than
the given integer.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util qw( sum0 );

   # Condense a string $x of digits by chopping it into groups of
   # $y digits, summing those groups, concatenating the sums, and
   # repeating until the length of the result is no more than $y:
   sub group_digit_sum ($x, $y) {
      my @groups = ();
      my @sums   = ();
      my $cat    = '';

      # Get digit groups:
      while (length($x) > 0) {
         push @groups, substr $x, 0, $y, '';
      }

      # Compute sums of groups:
      foreach my $idx (0..$#groups) {
         $sums[$idx] = sum0 split //, $groups[$idx];
      }

      # Concatenate sums:
      $cat .= $_ for @sums;

      # If $cat has no more than $y digits, return $cat:
      if (length($cat) <= $y) {return $cat}

      # Otherwise, recurse:
      else {return group_digit_sum($cat, $y)}
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : (["111122333",3],["1222312",2],["100012121001",4]);
#                  Expected outputs :        359            76               162

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $x = $aref->[0];
   my $y = $aref->[1];
   my $z = group_digit_sum($x, $y);
   say "digit string    = $x";
   say "group size      = $y";
   say "group digit sum = $z";
}
