#!/usr/bin/env perl

=pod

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 400-1,
written by Robbie Hatley on Tue Nov 17, 2026.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
PROBLEM DESCRIPTION:

Task 400-1: Largest Interval
Submitted by: Ali Moradi
You are given a positive integer. Write a script that generates a
sequence of integers from 1 to given positive integer, filtering
out any numbers that contain repeating digits (e.g., 11, 99, 100,
and 101 are excluded) and return the biggest jump.

(See "# INPUTS:" section below for examples.)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
PROBLEM NOTES:

We don't need to store the integers in an array; we need only keep track of "longest interval seen so far".

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a positive integer. For example:

./ch-1.pl '56789' '117463' '284706'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ────────────────────────────────────────────────────────────────────────────────────────────────────────────
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use utf8::all;
   $"=', ';

   # Does a given string contain repeated characters?
   sub rc ( $s ) {
      my @chars = split //, $s;
      my %hash;
      for ( @chars ) {
         return true if $hash{$_};
         ++$hash{$_};
      }
      return false;
   }

   # What is the longest gap between non-repeating integers?
   sub lg ( $x ) {
      my $prev = 1;
      my $lg   = 0;
      for my $int ( 2..$x ) {
         next if rc $int;
         $lg = $int - $prev if $int - $prev > $lg;
         $prev = $int;
      }
      $lg;
   }

# ────────────────────────────────────────────────────────────────────────────────────────────────────────────
# INPUTS:
my @ints = @ARGV ? @ARGV : (20, 110, 500, 2026, 10000);
# Expected outputs:          2    4   11   105    105

# ────────────────────────────────────────────────────────────────────────────────────────────────────────────
# MAIN BODY OF PROGRAM:
for my $int (@ints) {
   my $lg = lg $int;
   say "Longest gap between non-repeating ints from 1 through $int = $lg.";
}
