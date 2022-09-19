#!/bin/perl

=pod

The Weekly Challenge - 180
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-180/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Trim List
Submitted by: Mohammad S Anwar

You are given list of numbers, @n and an integer $i.

Write a script to trim the given list where element is less than or equal to the given integer.

=cut

use v5.16;
use warnings;

use Data::Printer;

use Test::More;
use Test::Deep qw(cmp_deeply);

# Prototype(s)
sub trimList(\@$);

my @l = (9,0,6,2,3,8,5);
my $ar = [1,2,3,4,5];

# Test 1: 'wantarray'
my @l2 = trimList(@l,4);
cmp_deeply(\@l,[9,0,6,2,3,8,5]);
cmp_deeply(\@l2,[9,6,8,5]);

# Test 2a: Modify list by reference
trimList(@l,4);
cmp_deeply(\@l,[9,6,8,5]);

# Test 2b: Modify list by reference
trimList(@$ar,2);
cmp_deeply($ar,[3,4,5]);

done_testing();


sub trimList (\@$) {
  my ($ar,$v) = @_;

  if (wantarray) {
    grep { $_ > $v } @$ar;
  } else {
    @$ar = grep { $_ > $v } @$ar;
  }
}

