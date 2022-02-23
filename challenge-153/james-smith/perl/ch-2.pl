#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @f = (1);
push @f, $_*$f[-1] foreach 1..9;

my @TESTS = ( [ 145, 1 ], [ 125, 0 ], );
is( is_factorion($_->[0])||0, $_->[1] ) foreach @TESTS;
done_testing();

## Has to be at most 7 digits as 8x9! < 9_999_999
## We note that 8x9^7 is the maximum possible value
## Further the value of this is 2_540_160. So we note
## that the maxium value is 2 + 6*9! or 2_177_282.
##
## So we are guaranteed to find all values if we
## search as far as this value...

is_factorion($_) && say for 1 .. 2_177_282;

sub is_factorion {
  my $t = $_[0];
  ($t-=$f[$_])||return 1 for split //,$t;
  return 0;
}

