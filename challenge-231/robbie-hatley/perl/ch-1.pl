#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 231-1.
Written by Robbie Hatley on Fri Aug 25, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Min Max
Submitted by: Mohammad S Anwar
You are given an array of distinct integers. Write a script to find all
elements which are neither minimum nor maximum. Return -1 if you can’t.

Example 1:
Input: @ints = (3, 2, 1, 4)
Output: (3, 2)
(The minimum is 1 and maximum is 4 in the given array. So (3, 2) are
the elements which are neither min nor max.)

Example 2:
Input: @ints = (3, 1)
Output: -1
(With only two distinct elements, each element is either min or max.)

Example 3:
Input: @ints = (2, 1, 3)
Output: (2)
(The minimum is 1 and maximum is 3 in the given array. So the only
element that's neither min nor max is 2.)


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I suppose I could use CPAN, but I feel like rolling my own tonight. Since the elements were specified to be
"distinct", I'll just sort the array using "my @sorted = sort {$a<=>$b} @array;", then the first element will
be the min ("my $min = shift @sorted;") and the last element will be max ("my $max = pop @sorted;").
Then just grab the middle: "my @middle; map {push @middle, $_ if $_ != $min && $_ != $max} @ints;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of distinct integers in proper Perl syntax, like so:
./ch-1.pl "([8,4,-17,43,-42,9],[47,17,87,62,38,50])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.38;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub not_min_or_max ($aref) {
   my @sorted = sort {$a<=>$b} @$aref;
   my $min = shift @sorted;
   my $max = pop   @sorted;
   my @middle;
   map {push @middle, $_ if $_ != $min && $_ != $max} @$aref;
   return @middle;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [3, 2, 1, 4],
   [3, 1],
   [2, 1, 3],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   my @middle = not_min_or_max($aref);
   say "array = (", join(', ', @$aref), ")";
   scalar(@middle) > 0
   and say "not-min-or-max = (", join(', ', not_min_or_max($aref)), ")"
   or  say "not-min-or-max = -1";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
