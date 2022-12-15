#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
   [15,14], [35,32]
);

is( special( $_->[0] ), $_->[1] ) for @TESTS;
done_testing();

sub special {
  scalar grep { !m{(\d).*\1} } 1..pop
}
