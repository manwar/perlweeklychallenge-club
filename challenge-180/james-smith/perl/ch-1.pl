#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use List::MoreUtils qw(firstidx);

my @TESTS = (
  [ 'Perl Weekly Challenge',  0 ],
  [ 'Long Live Perl',         1 ],
  [ 'P.O.O.P',               -1 ],
  [ 'tractors',               2 ],
);

is( first_unique($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub first_unique {
  my %counts;
  $counts{$_}++ for my @p = split //, pop;
  firstidx { $counts{$_} < 2 } @p;
}

