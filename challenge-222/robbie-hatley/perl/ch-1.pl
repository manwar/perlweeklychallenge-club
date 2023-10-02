#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
File name:    "ch-1.pl"
Description:  Solutions in Perl for The Weekly Challenge 222-1.
Authorship:   Written by Robbie Hatley on Thu Jun 22, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Matching Members
Submitted by: Mohammad S Anwar
You are given a list of positive integers, @ints. Write a script to find the total matching members after
sorting the list increasing order.

Example 1
Input: @ints = (1, 1, 4, 2, 1, 3)
Output: 3
Original list: (1, 1, 4, 2, 1, 2)
Sorted list  : (1, 1, 1, 2, 3, 4)
Compare the two lists, we found 3 matching members (1, 1, 2).

Example 2
Input: @ints = (5, 1, 2, 3, 4)
Output: 0
Original list: (5, 1, 2, 3, 4)
Sorted list  : (1, 2, 3, 4, 5)
Compare the two lists, we found 0 matching members.

Example 3
Input: @ints = (1, 2, 3, 4, 5)
Output: 5
Original list: (1, 2, 3, 4, 5)
Sorted list  : (1, 2, 3, 4, 5)
Compare the two lists, we found 5 matching members.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is simply a matter of comparing the sorted and unsorted versions of each array using a 3-part loop and
counting matching elements.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers in proper Perl syntax, like so:
./ch-1.pl '([8,4,32,7,9],[2,6,17,11,5])'

Output is to STDOUT and will be each original array, followed by the sorted version, followed by the count
of all "matching members".

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
sub count_matching_integers ($a1ref, $a2ref) {
   my $top = $#$a1ref;
      $top = $#$a2ref if $#$a2ref < $#$a1ref;
   my $count = 0;
   for ( my $i = 0 ; $i <= $top ; ++$i ) {
      ++$count if $$a1ref[$i] == $$a2ref[$i];
   }
   return $count;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [1, 1, 4, 2, 1, 3],
   [5, 1, 2, 3, 4],
   [1, 2, 3, 4, 5],
);

# Non-default inputs:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# Main loop:
for my $aref (@arrays) {
   say '';
   my $sref = [sort {$a<=>$b} @$aref];
   my $count = count_matching_integers($aref, $sref);
   say "original = (@$aref)";
   say "sorted   = (@$sref)";
   say "matching = $count";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.3fµs.\n", $µs);
