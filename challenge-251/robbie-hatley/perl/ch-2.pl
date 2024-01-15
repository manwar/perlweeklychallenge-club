#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 251-2.
Written by Robbie Hatley on Mon Jan 08, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 251-2: Lucky Numbers
Submitted by: Mohammad S Anwar
You are given a m x n matrix of distinct numbers. Write a script
to return the lucky number, if there is one, or -1 if not.
A lucky number is an element of the matrix such that it is
the minimum element in its row and maximum in its column.

Example 1:
Input: $matrix = [ [ 3,  7,  8],
                   [ 9, 11, 13],
                   [15, 16, 17] ];
Output: 15
15 is the only lucky number since it is the minimum in its row
and the maximum in its column.

Example 2:
Input: $matrix = [ [ 1, 10,  4,  2],
                   [ 9,  3,  8,  7],
                   [15, 16, 17, 12] ];
Output: 12

Example 3
Input: $matrix = [ [7 ,8],
                   [1 ,2] ];
Output: 7

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
First of all, "distinct numbers" is problematic because it would necessitate running equality comparison
between real numbers, which is problematic in computer programming because most computers do not store
exact representations of numbers such as 2/3 or π, much less 0.37e-5.16(3/7)πi. I'll import an "are_ints"
sub from an earlier PWCC submission to make sure all array elements are integers.

Secondly, I have to wonder if a matrix of integers always has either 0 or 1 "magic numbers"? It seems to me
that a matrix might have several. So I'll check for that by testing each row minimum to see if it's a column
maximum.

Thirdly, I can't use -1 to indicate "no lucky number" because -1 might actually BE a "lucky number" for a
given matrix! So instead, if there are no "lucky numbers", I'll print "Lucky numbers: None.".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of mxn matrices of unique integers, in proper Perl syntax, like so:
To test error checking:
./ch-2.pl '("Fred", [[7,18,4,9],[-5,-7,37]],[[1],[2]],[[1,2]],[[1,2],[3,1]],[[1,2],[3,4.4]],[[1,2],[3,4]])'
To test program function:
./ch-2.pl '([[7,-18,4,9],[0,-1,37,42],[16,-8,-14,33]],[[7,5,4,6],[8,3,1,2],[9,11,12,10],[27,34,14,19]])'
To run given examples:
./ch-2.pl

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
use List::Util qw(min max);

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 1; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Is a given scalar a reference to an m-by-n matrix of unique integers?
sub is_matrix_of_unique_ints ($aref) {
   # Bro, are you even a ref to an array?
   'ARRAY' ne ref($aref) and return 0;
   # At least two elements?
   my $m = scalar(@{$aref});
   $m < 2 and return 0;
   # And those elements, themselves, are arrays?
   for (@$aref) {'ARRAY' ne ref($_) and return 0;}
   # And the first row is at least 2 elements long?
   my $n = scalar(@{$$aref[0]});
   $n < 2 and return 0;
   # And all rows have the same length?
   for (@$aref) {scalar(@$_) != $n and return 0;}
   # And all elements are unique integers?
   my %h;
   for    ( my $i = 0 ; $i < $m ; ++$i ) {
      for ( my $j = 0 ; $j < $n ; ++$j ) {
         my $e = $aref->[$i]->[$j];
         return 0 if $e !~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/;
         return 0 if defined $h{$e};
         ++$h{$e}; # Autovivification is fun. :-)
      }
   }
   # Then $aref is a reference to an m-by-n matrix of unique integers:
   return 1;
}

# Is a given scalar in a given list?
sub is_in ($x, @a) {
   for (@a) {
      return 1 if $_ == $x;
   }
   return 0;
}

# Which elements of @$aref1 are also in @$aref2?
sub intersection ($aref1, $aref2) {
   my @i;
   for (@$aref1) {
      is_in($_, @$aref2) and push @i, $_;
   }
   return @i;
}

# Return the "lucky numbers" of a m-by-n matrix of unique integers:
sub lucky ($mref) {
   # Get the dimensions of the matrix:
   my $m = scalar(@{$mref});
   my $n = scalar(@{$mref->[0]});

   # Determine the row-minimums for each row:
   my @rmin;
   for ( my $i = 0 ; $i < $m ; ++$i ) {
      push @rmin, min(@{$mref->[$i]});
   }

   # Determine the column-maximums for each column:
   my @cmax;
   for ( my $j = 0 ; $j < $n ; ++$j ) {
      push @cmax, max(map {$mref->[$_]->[$j]} 0..$m-1);
   }

   # All members of @rmin which are also in @cmax are "lucky numbers":
   return intersection(\@rmin, \@cmax);
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [
      [ 3,  7,  8],
      [ 9, 11, 13],
      [15, 16, 17],
   ],
   # Expected Output: 15

   # Example 2 Input:
   [
      [ 1, 10,  4,  2],
      [ 9,  3,  8,  7],
      [15, 16, 17, 12],
   ],
   # Expected Output: 12

   # Example 3 Input:
   [
      [7 ,8],
      [1 ,2],
   ],
   # Expected Output: 7
);

# Main loop:
say '';
say 'PWCC 251-2, "Lucky Numbers":';
for my $mref (@matrices) {
   say '';
   !is_matrix_of_unique_ints($mref) and say 'Error: Not an m-by-n matrix of unique integers.'
                                    and say 'Skipping to next matrix.'
                                    and next;
   say 'Matrix = ';
   say join(' ', @$_) for @$mref;
   my @lucky = lucky($mref);
   scalar(@lucky) > 0 and say 'Lucky numbers: ' . join(' ', @lucky)
                      or  say 'Lucky numbers: None.';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
