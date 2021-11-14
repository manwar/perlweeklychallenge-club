#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @EXTRA_WORKDAYS = ( [qw(0 1 1 1 1 1 0)], [qw(1 2 2 2 2 1 0)] );
my @TESTS = (
  [ 2021, 261 ],
  [ 2020, 262 ],
);

is( work_days($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

#say $_, ' ', ly($_), ' ', zf($_), ' ', workdays($_) foreach 1900..2100;

sub leap_year {
  $_[0]&3 || (!($_[0]%100) && $_[0]%400) ? 0 : 1;
}
sub zellers_congruence_jan_1 {
  ( 1 + $_[0]%100 + ($_[0]%100>>2) - ($_[0]/100<<1) + ($_[0]/400>>0) ) % 7;
}

sub work_days {
  260 + $EXTRA_WORKDAYS[ leap_year $_[0] ][ zellers_congruence_jan_1 $_[0]-1 ];
}

