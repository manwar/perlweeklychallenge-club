#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 81,   1 ],
  [ 9801, 1 ],
  [ 36,   0 ],
);

is( check_square($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub check_square {
  $_[0] <= 1 ? 0 : split_no( sqrt($_[0]), $_[0], 0 );
}

sub split_no {
  my( $sum, $str ) = @_;
  return 0 if $sum < 0;
  return 0 if $str eq '' && $sum;
  return 1 if $str eq '';
  return 1 if grep { split_no( ($sum - substr $str,$_) , substr $str, 0, $_ ) }
              0 .. -1 + length $str;
  return 0;
}

