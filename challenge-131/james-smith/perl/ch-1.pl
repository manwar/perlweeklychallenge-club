#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [qw(1 2 3 6 7 8 9)] ],
  [ [qw(11 12 14 17 18 19)] ],
  [ [qw(2 4 6 9)] ],
  [ [qw(1 2 3 4 5)] ],
);

#is( ($_->[0]), $_->[1] ) foreach @TESTS;
#done_testing();

say con_dump( conseq( $_->[0] ) ) foreach @TESTS;

sub con_dump {
  return sprintf '(%s)', join ', ',map { sprintf '[%s]', join ', ', @{$_} } @{$_[0]};
}

sub conseq {
  my @val = @{$_[0]};
  my @res = ( [shift @val] );
  ( $_ == 1 + $res[-1][-1] ) ? (push @{$res[-1]},$_) : (push @res,[$_]) foreach @val;
  return \@res;
}

