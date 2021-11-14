#!/bin/perl

=pod

Perl Weekly Challenge - 135
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-135/#TASK2

Author: Niels 'PerlBoy' van Dijke

SK #2 › Validate SEDOL
Submitted by: Mohammad S Anwar

You are given 7-characters alphanumeric SEDOL.

Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL otherwise 0.

For more information about SEDOL, please checkout the wikipedia page.

=cut

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);

use Test::More;

# Prototype(s)
sub isSEDOL($);

is isSEDOL(2936921),1;
is isSEDOL(1234567),0;
is isSEDOL('B0YBKL9'),1;
is isSEDOL('A00000'),0;
is isSEDOL('B000010'),1;

done_testing;


sub isSEDOL($) {
  if (uc $_[0] =~ m#^([0-9B-DF-HJ-NP-TV-Z]{6})(\d)$#) {
    my ($d,$c) = ($1,$2);
    my @w = (1,3,1,7,3,9,1);
    my $i = 0;
    my %v = +map{($_,$i++)} (0..9,'A'..'Z');
    return ((10-sum(map{$v{$_}*shift(@w)}split(//,$d))%10)%10)==$c?1:0;
  } else {
    return 0;
  }
}
