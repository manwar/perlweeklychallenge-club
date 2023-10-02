#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Solutions in Perl for The Weekly Challenge 225-2.
Written by Robbie Hatley on Sunday July 9, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Left Right Sum Diff
Submitted by: Mohammad S Anwar
You are given an array of integers, @ints.
Write a script to return the left right sum diff array as shown below:
@ints  = (a, b, c, d, e)
@left  = (     0,         a,   (a+b), (a+b+c), (a+b+c+d) )
@right = ( (b+c+d+e), (c+d+e), (d+e),    e,        0     )
@left_right_sum_diff =
(
   |   0       - (b+c+d+e) |,
   |   a       -  (c+d+e)  |,
   | (a+b)     -   (d+e)   |,
   | (a+b+c)   -     e     |,
   | (a+b+c+d) -     0     |,
)

Example 1:
Input: @ints = (10, 4, 8, 3)
Output: (15, 1, 11, 22)
@left  = (0, 10, 14, 22)
@right = (15, 11, 3, 0)
@left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
                     = (15, 1, 11, 22)

Example 2:
Input: @ints = (1)
Output: (0)
@left  = (0)
@right = (0)
@left_right_sum_diff = ( |0-0| ) = (0)

Example 3:
Input: @ints = (1, 2, 3, 4, 5)
Output: (14, 11, 6, 1, 19)
@left  = (0, 1, 3, 6, 10)
@right = (14, 12, 9, 5, 0)
@left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
                     = (14, 11, 6, 1, 10)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of making subs to compute "left" and "right" sequences of partial sums of as defined
by this problem (which is NOT the way math textbooks define "sequence of partial sums", by the way),
then computing the array of absolute values of index-wise differences between @left and @right.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers in proper Perl syntax, like so:
./ch-2.pl '([13,0,96,-8,3],[11,2,6,4,-83,-42])'

Output is to STDOUT and will be each input array, followed by the corresponding Left-Right Sum-Diff Array.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:
sub lsps ($aref) { # "lsps" = "Left Sequence of Partial Sums"
   my $size = scalar @$aref;
   my @lsps = ();
   for ( my $i = 0 ; $i < $size ; ++$i ) {
      my $term = 0;
      for ( my $j = 0 ; $j < $i ; ++$j ) {
         $term += $$aref[$j];
      }
      push @lsps, $term;
   }
   return @lsps
}

sub rsps ($aref) { # "rsps" = "Right Sequence of Partial Sums"
   my $size = scalar @$aref;
   my @lsps = ();
   for ( my $i = 0 ; $i < $size ; ++$i ) {
      my $term = 0;
      for ( my $j = $i+1 ; $j < $size ; ++$j ) {
         $term += $$aref[$j];
      }
      push @lsps, $term;
   }
   return @lsps
}

sub diff ($aref1, $aref2) { # "diff" = "difference of sequences"
   my $size1 = scalar @$aref1;
   my $size2 = scalar @$aref2;
   if ($size1 != $size2) {
      die "Error in sub \"dos\": arrays not same size!\n$!\n";
   }
   my @diffs;
   for ( my $i = 0 ; $i < $size1 ; ++$i ) {
      push @diffs, abs($$aref1[$i]-$$aref2[$i]);
   }
   return @diffs;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [10, 4, 8, 3],
   [1],
   [1, 2, 3, 4, 5],
);

# Non-default inputs:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# Main loop:
for my $aref (@arrays) {
   my @lsps = lsps($aref);
   my @rsps = rsps($aref);
   my @diff = diff(\@lsps, \@rsps);
   say '';
   say "array = (@$aref)";
   say "lsps  = (@lsps)";
   say "rsps  = (@rsps)";
   say "diff  = (@diff)";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
exit 0;
