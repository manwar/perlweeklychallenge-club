#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 229-1.
Written by Robbie Hatley on Mon Aug 07, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Lexicographic Order
Submitted by: Mohammad S Anwar
You are given an array of strings. Write a script to delete each string in which the letters do not occur
in a lexicographically-sorted order, either forwards or backwards, and return a count of deletions.

Example 1:  Input: @str = ("abc", "bce", "cae")  Output: 1
(In the given array "cae" is the only element which is not lexicographically sorted.)

Example 2:  Input: @str = ("yxz", "cba", "mon")  Output: 2
(In the given array "yxz" and "mon" are not lexicographically sorted.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll take the approach of writing a sub to sort strings forward and backward, then comparing each string to
its forward and backward version, erasing each string which does not match at least one, and counting those
deletions.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be
a double-quoted array of arrays of single-quoted strings, in proper Perl syntax, like so:
./ch-1.pl "(['I go.', 'She ran home.', 'I ate seven hot dogs.'],['She sat.', 'I didn\'t sit.'])"

Output is to STDOUT and will be each input array followed by the corresponding output.

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

sub is_monotonic ($word) {
   my $fwd = join '', sort {$a cmp $b} split //, $word;
   my $bwd = join '', sort {$b cmp $a} split //, $word;
   $word eq $fwd || $word eq $bwd and return 1 or return 0;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   ["abc", "bce", "cae"],
   ["yxz", "cba", "mon"],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   my @array = @$aref;
   my @removed = ();
   my $count = 0;
   for ( my $i = 0 ; $i <= $#array ; ++$i ) {
      if ( !is_monotonic($array[$i]) ) {
         push @removed, splice @array, $i, 1;
         ++$count;
         --$i;
      }
   }
   say '';
   say "original array = (@$aref)";
   say "monotone array = (@array)";
   say "removed  items = (@removed)";
   say "deleted $count items";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
