#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @FACT = (1);
push @FACT, $_*$FACT[-1] foreach 1..9;

my @TESTS = ( [ 145, 1 ], [ 125, 0 ], );
is( is_factorion($_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

is_factorion($_) && say for 1 .. 2_177_282;

sub is_factorion {
  my $t=0;
  $t+=$FACT[$_] for split //,$_[0];
  $t==$_[0];
}

