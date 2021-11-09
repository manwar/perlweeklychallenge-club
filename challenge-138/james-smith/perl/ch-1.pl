#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @EXTRA = ( [qw(0 1 1 1 1 1 0)], [qw(1 2 2 2 2 1 0)] );
my @TESTS = (
  [ 2021, 261 ],
  [ 2020, 262 ],
);

is( workdays($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

#say $_, ' ', ly($_), ' ', zf($_), ' ', workdays($_) foreach 1900..2100;

sub workdays {
  260 + $EXTRA[ ly($_[0]) ][ zf($_[0]) ];
}

sub ly {
  $_[0]%4 || (!($_[0]%100) && $_[0]%400) ? 0 : 1;
}

sub zf {
  ( 1 + (my$y=$_[0]-1)%100 + ($y%100>>2) + ($y/400<<0) - ($y/100<<1) )%7;
}

