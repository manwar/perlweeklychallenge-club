#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ '03:10', 35 ],
  [ '04:00', 120 ],
);

is( clock_angle($_->[0]), $_->[1] ) foreach @TESTS;
is( clock_angle_1_liner($_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

cmpthese( 2_000_000, {
  'f' => sub { clock_angle($_->[0]) foreach @TESTS },
  '1' => sub { clock_angle_1_liner($_->[0]) foreach @TESTS },
});

sub clock_angle {
## The difference is: hr*30+min/2 - min*12
## Modulo is int based so to avoid issue
## when min is even we multiply by 2 take
## modulus and then divide by 2.
## If value is > 180 then we subtract from
## 360....
  my($h,$m) = split /:/,shift;
  my $a = abs($h*60-$m*11)%720/2;
  return $a > 180 ? 360-$a : $a;
}

sub clock_angle_1_liner {
  180-abs(abs(60*(substr$_[0],0,2)-11*substr$_[0],3)%720/2-180);
}
