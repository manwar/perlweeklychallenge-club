#!/usr/bin/perl

# Perl Weekly Challenge - 123
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-123/#TASK2
#
# Task 1 - Square Points
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(frequency);

use Test::More;

# Prototype(s)
sub areSquarePoints(\@);


my $tests = [ 
   [ [10,20],[20,20],[20,10],[10,10], 1 ],
   [ [12,24],[16,10],[20,12],[18,16], 0 ],
   [ [10,24],[12,24],[10,12],[18,16], 0 ],
   [ [20,20],[20,10],[10,10],[10,20], 1 ],
];

foreach my $t (@$tests) {
  my $res = pop(@$t);
  is(areSquarePoints(@$t),$res);
}

done_testing();


sub areSquarePoints(\@) {
  my ($ar) = @_;

  my %xF = frequency map {$_->[0]} @$ar;
  my %yF = frequency map {$_->[1]} @$ar;

  return (scalar(keys %xF) == 2 && scalar(keys %yF) == 2 ? 1: 0);
}
