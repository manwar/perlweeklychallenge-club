#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 359-1,
written by Robbie Hatley on Tue Feb 03, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 359-1: Digital Root
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int. Write a function that
calculates the additive persistence of a positive integer and
also return the digital root. Digital root is the recursive sum
of all digits in a number until a single digit is obtained.
Additive persistence is the number of times you need to sum the
digits to reach a single digit.

Example #1:
Input: $int = 38
Expected output: Digital Root = 2; Persistence = 2

Example #2:
Input: $int = 7
Expected output: Digital Root = 7; Persistence = 0

Example #3:
Input: $int = 999
Expected output: Digital Root = 9; Persistence = 2

Example #4:
Input: $int = 1999999999
Expected output: Digital Root = 1; Persistence = 3

Example #5:
Input: $int = 101010
Expected output: Digital Root = 3; Persistence = 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of performing the calculations described and seeing what one gets.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of positive integers, in proper Perl syntax, like so:

./ch-1.pl '(7, 16, 482, 9271, 37846)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'sum0';

   # Calculate the Digital Root and Persistence
   # of a given positive integer:
   sub drps ( $x ) {
      my $dr = $x; # digital root
      my $ps =  0; # persistence
      while ( length($dr) > 1 ) {
         $dr = sum0 split '', $dr;
         ++$ps
      };
      return ($dr, $ps);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) : (  38,     7,    999,  1999999999, 101010  );
#                Expected outputs :   (2,2)  (7,0)  (9,2)     (1,3)     (3,1)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $int (@ints) {
   say '';
   say "Input Integer = $int";
   my ($dr, $ps) = drps($int);
   say "Digital Root  = $dr";
   say "Persistence   = $ps";
}
