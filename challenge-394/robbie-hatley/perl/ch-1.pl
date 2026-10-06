#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 394-1,
written by Robbie Hatley on Mon Oct 05, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 394-1: Alternate Case
Submitted by: Mohammad Sajid Anwar
You are given a string containing an equal number of uppercase
and lowercase English letters. Write a script to the minimum
number of adjacent character swaps needed to turn the given
string into an alternate case string.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

We need not perform any swaps at all. Instead, we need only note that there are only two possible ending
patterns of uppercase indices: (0, 2, 4,...) or (1, 3, 5,...). We need only count the costs to achieve each
of those patterns. And those costs will be the sums of the distances each upper-case letter will have to move
to go from its current position to its new position in (0, 2, 4,...) or (1, 3, 5,...). Then just return the
lesser of those two costs.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a string of English letters with equal numbers of lower-case and UPPER-CASE
letters. For example:

./ch-1.pl 'RoBBieHatLeY' 'mOhAMmAdSaJidAnWAr'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;

   # What is the minimum number of swaps of adjacent
   # letters needed to make an alternating-case string?
   sub least_swaps ( $s ) {
      # What are our letters?
      my @letters = split //, $s;

      # Where are the uppers?
      my @uppers = ();
      foreach my $index (0..$#letters) {
         if ($letters[$index] =~ m/^[A-Z]$/) {
            push @uppers, $index
         }
      }

      # Cost to achieve "UlUlUl":
      my $ucost = 0;
      for my $index (0..$#uppers) {
         $ucost += abs($uppers[$index] - (2*$index+0));
      }

      # Cost to achieve "lUlUlU":
      my $lcost = 0;
      for my $index (0..$#uppers) {
         $lcost += abs($uppers[$index] - (2*$index+1));
      }

      # Return least cost:
      $lcost < $ucost ? $lcost : $ucost;
   }

   # Is a given string valid?
   sub is_valid ( $s ) {
      return false if $s !~ m/^[A-Za-z]*$/;
      my @letters = split //, $s;
      my $count_of_lowers = 0;
      my $count_of_uppers = 0;
      foreach my $letter (@letters) {
         ++$count_of_uppers if $letter =~ m/^[A-Z]$/;
         ++$count_of_lowers if $letter =~ m/^[a-z]$/;
      }
      return ($count_of_lowers == $count_of_uppers) ? true : false;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV : ("aAbB", "AAbb", "AAAbbb", "aABb", "bBBAaa");
# Expected outputs:              0        1        3        1        2

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say "String = $string";
   if (!is_valid($string)) {
      say STDERR "Error: String must consist only of English letters,\n"
                ."with equal numbers of lower-case and upper-case letters.\n";
      next;
   }
   my $ls = least_swaps($string);
   say "Least swaps to make alternating-case string = $ls";
}
