#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 399-1,
written by Robbie Hatley on Sun Nov 15, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 399-1: Longest Repeating Character
Submitted by: Mohammad Sajid Anwar
You are given a string str and an integer k > 0. Write a script
to choose any character of str and change it to another character.
You may perform this operation up to k times. Return the length
of the longest reachable substring of a single letter.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

To solve this problem, I'll generate every substring of the string, then calculate the aomac (Abundance Of
Most-Abundant Character) for each substring. Then if length - aomac is less-than-or-equal to k and length is
greater than max, update max. Then simply return max.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated sequence of a string followed by a positive integer.
For example:

./ch-1.pl 'Mississippi,1' 'ratatattat,2' ',3' 'abcdefg,0'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use utf8::all;
   $"=', ';

   # Abundance Of Most-Abundant Character:
   sub AOMAC ( $s ) {
      my $max = 0;
      my %h;
      ++$h{$_} for split //, $s;
      $h{$_} > $max and $max = $h{$_} for keys %h;
      return $max;
   }

   # Return the substrings of a string:
   sub substrings ( $s ) {
      my @ss;
      my $n = length $s;
      for    ( my $i = 0 ; $i <= $n-1  ; ++$i ) {
         for ( my $l = 1 ; $l <= $n-$i ; ++$l ) {
            push @ss, substr $s, $i, $l;
         }
      }
      return @ss;
   }

   # How large of a same-letters block can we make?
   sub max_block_size ( $s , $k ) {
      my $max = 0;
      my @ss = substrings($s);
      foreach my $s ( @ss ) {
         my $l = length $s;
         next unless $l > $max;
         my $aomac = AOMAC($s);
         $max = $l if $l - $aomac <= $k;
      }
      return $max;
   }

   # Parse lists of strings:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         push @args, [map {trim $_} split /,/, $bash_arg, -1];
      }
      return @args;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   [ "AAAAA"     , 2 ], # 5
   [ "ABCDE"     , 4 ], # 5
   [ "AAABBBBAA" , 1 ], # 5
   [ "ABACADA"   , 2 ], # 5
   [ "BAAABAAAA" , 1 ], # 8
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my $s = $aref->[0];
   my $k = $aref->[1];
   my $l = max_block_size($s, $k);
   say "String = \"$s\". Max replacements = $k. Longest block = $l.";
}
