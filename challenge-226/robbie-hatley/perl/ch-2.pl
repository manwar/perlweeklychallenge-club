#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 226-2.
Written by Robbie Hatley on Mon Jul 17, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Zero Array
Submitted by: Mohammad S Anwar

You are given an array of non-negative integers, @ints. Write a script to return the minimum number of
operations to make every element equal zero. In each operation, you are required to pick a positive number
less than or equal to the smallest element in the array, then subtract that from each positive element in
the array.

Example 1:
Input: @ints = (1, 5, 0, 3, 5)
Output: 3
operation 1: pick 1 => (0, 4, 0, 2, 4)
operation 2: pick 2 => (0, 2, 0, 0, 2)
operation 3: pick 2 => (0, 0, 0, 0, 0)

Example 2:
Input: @ints = (0)
Output: 0

Example 3:
Input: @ints = (2, 1, 4, 0, 3)
Output: 4
operation 1: pick 1 => (1, 0, 3, 0, 2)
operation 2: pick 1 => (0, 0, 2, 0, 1)
operation 3: pick 1 => (0, 0, 1, 0, 0)
operation 4: pick 1 => (0, 0, 0, 0, 0)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
There is no need to actually do any "operations". All we need to note is that the number of operations
required will be equal to the number of unique positive integers present, so I'll just count those,
using a hash to keep track of ones we've seen before.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of non-negative integers, in proper Perl syntax, like so:
./ch-2.pl "([0,17,6,17,4,2],[1,2,3,4,5,6])"

Output is to STDOUT and will be each input array followed by corresponding output.

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
sub are_non_neg_ints ($aref) {
   for (@$aref) {
      return 0 if $_ !~ m/(?:^0$)|(?:^[1-9]\d*$)/;
   }
   return 1;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [1, 5, 0, 3, 5],
   [0],
   [2, 1, 4, 0, 3],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   say "Array: (@$aref)";
   if ( ! are_non_neg_ints($aref) ) {
      say "Error: array must contain only non-negative integers.";
      say "Moving on to next array.";
      next;
   }
   my $n = 0;
   my %h;
   $h{0} = 'yes';
   for (@$aref) {
      next if defined $h{$_};
      ++$n;
      $h{$_} = 'yes';
   }
   say "Number of operations required = $n";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
