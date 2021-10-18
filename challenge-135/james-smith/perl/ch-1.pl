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

is( middle3($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub middle3 {
  my $n = shift;
  return 'Not a number' unless $n =~ m{^-?\d+$};
  return 'Too short'    unless $n =~ m{\d{3}};
  return 'Even digits'  if $n =~ m{^-?(?:\d\d)+$};
  $n =~ s{^-}{};
  return substr $n, (-3 + length $n ) / 2, 3;
}

