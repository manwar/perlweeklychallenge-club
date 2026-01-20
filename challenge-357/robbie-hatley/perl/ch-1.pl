#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 357-1,
written by Robbie Hatley on Mon Jan 19, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 357-1: Kaprekar Constant
Submitted by: Mohammad Sajid Anwar

Write a function that takes a 4-digit integer and returns
how many iterations of the following algorithm are required
to reach Kaprekar’s constant (6174). (For more information about
Kaprekar's Constant, see "https://en.wikipedia.org/wiki/6174".)

   1. Select any four-digit number that has at least two
      different digits (leading zeros are allowed).
   2. Create two new four-digit numbers by arranging the
      original digits in a.) ascending and b.) descending order
      (adding leading zeros if necessary).
   3. Subtract the smaller number from the bigger number.
      If the result is not 6174, return to step 2 and repeat.

Example inputs:   ("3524","6174","9998","1001","9000","1111")
Expected outputs: (   3      0      5      4      4      -1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I just run the calculations expressed on the linked web site and see what happens.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings of 4 decimal digits, in proper Perl syntax, like so:

./ch-1.pl '("3705", "8652", "0074", "1396", "2347")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # How many iterations to reach the Kaprekar constant
   # for 4-digit decimal expansions of non-negative integers
   # (using left-zero-padding if necessary)?
   sub Kaprekar ( $x ) {
      return -1 if $x !~ m/^\d{4}$/;
      return -1 if $x =~ m/^(0000|1111|2222|3333|4444)$/;
      return -1 if $x =~ m/^(5555|6666|7777|8888|9999)$/;
      my $curr = $x;
      my $i = 0;
      while ('6174' ne $curr) {
         my $u = join '', sort {$a<=>$b} split '', $curr;
         my $d = join '', sort {$b<=>$a} split '', $curr;
         $curr = $d - $u;
         $curr = '0'.$curr while (length($curr)<4);
         ++$i;
      }
      $i
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) : ("3524","6174","9998","1001","9000","1111");
#                Expected outputs : (   3      0      5      4      4      -1 )

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $int (@ints) {
   say '';
   say "Integer: $int";
   my $k = Kaprekar($int);
   say "Iterations: $k";
}
