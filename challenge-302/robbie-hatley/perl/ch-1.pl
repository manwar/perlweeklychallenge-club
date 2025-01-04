#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 302-1,
written by Robbie Hatley on Mon Dec 30, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 302-1: "Ones and Zeroes"
Submitted by: Mohammad Sajid Anwar
You are given an array of binary strings, @str, and two
integers, $x and $y. Write a script to return the size of the
largest subset of @str such that there are at most $x 0’s and
$y 1’s in the subset. A set m is a subset of n if all elements
of m are also elements of n.

Example #1:
Input: @str = ("10", "0001", "111001", "1", "0")
$x = 5
$y = 3
Output: 4
The largest subset with at most five 0's and three 1's:
("10", "0001", "1", "0")

Example #2:
Input: @str = ("10", "1", "0")
$x = 1
$y = 1
Output: 2
The largest subset with at most one 0's and one 1's:
("1", "0")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

Since this problem's description mentions "subset", I'll assume that @str is required to be a "set" (that is,
a collection of UNIQUE elements). I'll use my favorite CPAN module, "Math::Combinatorics", to create the power
set of @str by collecting all "n choose m" combinations of all allowable m values (0..n). I'll then iterate
through the power set looking for the largest which is within the given limits on 0s and 1s.

And since this problem's description speaks of $x and $y as being limits on number of 0s and 1s respectively,
I'll assume that $x and $y must be non-negative integers.

Since this program will depend on the inputs being valid to work, I'll start by writing a "inputs_are_valid"
subroutine (for checking inputs), then a "meets_criteria" subroutine (to determine if a given subset meets the
given limits on 0s and 1s), then a "largest_subset" subroutine (which returns the largest subset meeting the
given limits on 0s and 1s).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, in proper Perl syntax. Each inner array should start with two non-negative
integers followed by a list of double-quoted binary strings (strings not containing any character other than
"0" or "1"). For example:
./ch-1.pl '([8, 5, "0101", "1010", "1111", "0000", "10110010"],[10, 15, "1111111", "0101", "1010", "000000"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use Math::Combinatorics;

   # Do we have valid inputs?
   sub inputs_are_valid ($x, $y, @strings) {
      if ($x !~ m/^0$|^[1-9]\d*$/) {
         say "Error: \$x is not a non-negative integer.";
         return 0;
      }
      if ($y !~ m/^0$|^[1-9]\d*$/) {
         say "Error: \$y is not a non-negative integer.";
         return 0;
      }
      for my $string (@strings) {
         if ($string !~ m/^[01]*$/) {
            say "Error: \@strings is not an array of binary strings.";
            return 0;
         }
      }
      for (    my $i =   0  ; $i <= $#strings-1 ; ++$i ) {
         for ( my $j = $i+1 ; $j <= $#strings-0 ; ++$j ) {
            if ( $strings[$i] eq $strings[$j] ) {
               say "Error: \@strings is not a set of unique elements.";
               return 0;
            }
         }
      }
      return 1;
   }

   # Does a given set of strings meet given limits on 0s and 1s?
   sub meets_criteria ($x, $y, @strings) {
      my $zeros = 0;
      my $ones  = 0;
      for my $string (@strings) {
         $zeros += length $string =~ s/[^0]//gr;
         $ones  += length $string =~ s/[^1]//gr;
      }
      $zeros <= $x && $ones <= $y;
   }

   # What is the first largest subset found meeting the given
   # maximum numbers of 0s and 1s?
   sub largest_subset ($x, $y, @strings) {
      # First declare the various variables we'll need:
      my @largest = (); # Largest conforming subset.
      my $lsize   =  0; # Size of largest conforming subset.
      my @power   = (); # Power set of @strings.
      my $n = scalar(@strings); # Number of strings.
      # Make the power set (set of all subsets) of @strings,
      # by collecting all combinations of all possible sizes:
      for my $m (0..$n) {push @power, combine($m, @strings)}
      # Riffle through those subsets and find the first largest
      # subset conforming to the given limits on 0s and 1s:
      for my $sref (@power) {
         my @subset = @$sref;
         if (meets_criteria($x, $y, @subset)) {
            if (scalar(@subset) > $lsize) {
               @largest = @subset;
               $lsize = scalar(@subset);
            }
         }
      }
      return @largest;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([5, 3, "10", "0001", "111001", "1", "0"] , [1, 1, "10", "1", "0"]);
#                  Expected outputs :                      4                                  2

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @strings = @$aref;
   my $x = shift @strings;
   my $y = shift @strings;
   say "Strings = (@strings)";
   say "Limit on 0s = $x";
   say "Limit on 1s = $y";
   next if !inputs_are_valid($x, $y, @strings);
   my @largest = largest_subset($x, $y, @strings);
   my $size = scalar(@largest);
   say "First largest subset found meeting given criteria = (@largest)";
   say "Size = $size";
}
