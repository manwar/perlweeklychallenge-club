#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 237-2.
Written by Robbie Hatley on Fri Oct 06, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Maximize Greatness
Submitted by: Mohammad S Anwar
You are given an array of integers. Write a script to permute the
given array such that you get the maximum possible "greatness".
To determine "greatness", nums[i] < perm[i] where 0 <= i < nums.length

Example 1:
Input: @nums = (1, 3, 5, 2, 1, 3, 1)
Output: 4
One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns
4 greatness as below:
nums[0] < perm[0]
nums[1] < perm[1]
nums[3] < perm[3]
nums[4] < perm[4]

Example 2:
Input: @ints = (1, 2, 3, 4)
Output: 3
One possible permutation: (2, 3, 4, 1) which returns
3 greatness as below:
nums[0] < perm[0]
nums[1] < perm[1]
nums[2] < perm[2]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I've no time to re-invent yet-another array-permutations subroutine this weekend so I'll use CPAN module
"Math::Combinatorics", which has come to my aid in so many of these weekly challenges. Then it's just a
matter of checking the "greatness" of every possible permutation of a given array and keeping track of
"maximum greatness found so far".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers in proper Perl syntax, like so:
./ch-2.pl '([3,7,8,4,1,6,2,5],[9,3,62,-8])'

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';
use Math::Combinatorics;

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub greatness ($a1ref, $a2ref) {
   my $g = 0; # greatness
   for ( my $i = 0 ; $i <= $#$a1ref && $i <= $#$a2ref ; ++$i ) {
      ++$g if ($$a1ref[$i] < $$a2ref[$i])
   }
   return $g;
}

sub max_greatness ($aref) {
   my $g  = 0; # greatness
   my $mg = 0; # max greatness
   my $perms = Math::Combinatorics->new(count => $#$aref, data => $aref);
   while ( my @perm = $perms->next_permutation ) {
      $g = greatness($aref, \@perm);
      $mg = $g if $g > $mg;
   }
   return $mg
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 3, 5, 2, 1, 3, 1],
   [1, 2, 3, 4],
);

# Main loop:
for my $aref (@arrays) {
   my $mg = max_greatness($aref);
   say '';
   say 'Array = (', join(', ', @$aref), ')';
   say "Max greatness = $mg";
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {
   my $ms = 1000 * (time - $t0);
   printf("\nExecution time was %.3fms.\n", $ms)
}
__END__
