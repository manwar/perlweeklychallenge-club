#!/usr/bin/perl

# Perl Weekly Challenge - 078
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
#
# Task 2 - Left Rotation
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

my @A = qw(7 4 2 6 3);
my @B = qw(1 3 4);

sub rotateArray {
  my ($arL, $arR) = @_;

  my @res;

  my $maxIdx = scalar(@$arL) - 1 ;

  foreach my $r (@$arR) {
    $r %= ($maxIdx + 1); 
    push(@res, [@$arL[$r .. $maxIdx], @$arL[0 .. $r - 1]]);
  }

  return @res;
}  

printf "Input:\n\t\@A = (%s)\n\t\@B = (%s)\n", 
  join(', ', @A), join(', ', @B);
printf "Output:\n%s\n", 
  join("\n", map { "\t[".join(" ", @$_)."]" } rotateArray(\@A, \@B));
