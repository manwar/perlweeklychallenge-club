#! /usr/bin/env perl

# PWCC_190_P1_Capital-Correctness_Robbie-Hatley.pl

=pod

Task 1: Capital Detection
Submitted by: Mohammad S Anwar
You are given a string with alphabetic characters only: A..Z and a..z.
Write a script to find out if the usage of Capital is appropriate.
It's appropriate if it satisfies at least one of the following rules:
1) Only first letter is capital and all others are small.
2) Every letter is small.
3) Every letter is capital.

=cut

# NOTE: Input is via built-in-array (default) or CLI. If using CLI,
#       input should be space-separated sequence of unquoted clusters
#       of English letters (/[a-zA-Z]+/).

# NOTE: Output will be to stdout and will consist of a 0 or 1 for
#       each letter cluster, 0 meaning "inappropriate capital use"
#       and 1 meaning "appropriate capital use".

use v5.36;

sub appropriate ($string)
{
   $string =~ m/(^[A-Z][a-z]*$)|(^[a-z]+$)|(^[A-Z]+$)/ and return 1
   or  return 0;
}

my @array = qw( Perl TPF PyThon raku );
if (scalar(@ARGV)>0) {@array = @ARGV}

for (@array)
{
   my $a = appropriate($_);
   $a and say "$a - capitalization of $_ is correct."
      or  say "$a - capitalization of $_ is incorrect.";
}
