#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 123456789, 456 ],
  [ -1234567, 345 ],
  [ 1234567, 345 ],
  [ -123,    123 ],
  [ 1,       'Too short'    ],
  [ 'dred',  'Not a number' ],
  [ 1000,    'Even digits'  ],
);

is( middle3(        $_->[0]), $_->[1] ) foreach @TESTS;
is( middle3compact( $_->[0]), $_->[1] ) foreach @TESTS[0..4,6];

done_testing();

sub middle3 {
  my $n = shift;
  return 'Not a number' unless $n =~ m{^-?\d+$};
  my $l = length( $n = abs $n );
  return $l < 3 ? 'Too short'
       : $l % 2 ? substr $n, ( $l - 3 ) / 2, 3
       :          'Even digits'
       ;
}

sub middle3compact {
  my$l=length(my$n=abs$_[0]);
  return$l<3?'Too short':$l%2?substr$n,$l/2-1,3:'Even digits';
}

