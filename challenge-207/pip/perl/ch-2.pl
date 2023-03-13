#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #207 - Pip Stuart
# Task2: H-Index:  Submitted by: Mohammad S Anwar;  You are given an array of integers containing citations a researcher has received for each paper.
#   Write a script to compute the researcher’s H-Index. For more information please checkout the wikipedia page.
#     The H-Index is the largest number h such that h articles have at least h citations each. For example, if an author has five publications, with 9, 7, 6,
#     2, and 1 citations (ordered from greatest to least), then the author’s h-index is 3, because the author has three publications with 3 or more citations.
#     However, the author does not have four publications with 4 or more citations.
# Example1:
#   In-put: @citations = (10,8,5,4,3)
#   Output: 4                         Because the 4th publication has 4 citations and the 5th has only 3.
# Example2:
#   In-put: @citations = (25,8,5,3,3)
#   Output: 3                         The H-Index is 3 because the fourth paper has only 3 citations.
# Last date to submit the solution 23:59 (UK Time) Sunday 12th March 2023.
use strict;use warnings;use utf8;use v5.12;my $d8VS='N38LDAYS';
sub HNdx {my @ctnz = sort { $b <=> $a } @_;my $hndx = 0;
  while ($hndx < @ctnz && $ctnz[$hndx] > $hndx) { $hndx++; }
  printf("(%-10s) => %d;\n", join(',', @ctnz), $hndx);
  return($hndx);
}
if    (@ARGV) {
  HNdx(@ARGV);
} else {
  HNdx(10,8,5,4,3); # => 4;
  HNdx(25,8,5,3,3); # => 3;
}
