#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 1234567, 345 ],
  [ -123,    123 ],
  [ 1,       'Too short'    ],
  [ 'dred',  'Not a number' ],
  [ 1000,    'Even digits'  ],
);

is( middle3(  $_->[0]), $_->[1] ) foreach @TESTS;
is( middle3no($_->[0]), $_->[1] ) foreach @TESTS[0..2,4];

done_testing();

sub middle3 {
  my $n = shift;
  return 'Not a number' unless $n =~ m{^-?\d+$};
  $n = abs $n;
  return length $n < 3 ? 'Too short'
       : (length $n)%2 ? substr $n, (-3 + length $n ) / 2, 3
       :                 'Even digits'
       ;
}

sub middle3no {
  my $n = abs shift;
  return length $n < 3 ? 'Too short'
       : (length $n)%2 ? substr $n, (-3 + length $n ) / 2, 3
       :                 'Even digits'
       ;
}

