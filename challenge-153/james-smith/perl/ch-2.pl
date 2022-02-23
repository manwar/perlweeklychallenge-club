#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

## Prep for tests!
my @f = (1);
push @f, $_*$f[-1] foreach 1..9;
my @t = map { my $t = $_; map {$t+$_} @f } @f;
my @q = map { my $t = $_; map {$t+$_} @f } @t;

my @TESTS = ( [ 145, 1 ], [ 125, 0 ], );
is( is_factorion(    $_->[0])||0, $_->[1] ) foreach @TESTS;
is( is_factorion_1k( $_->[0])||0, $_->[1] ) foreach @TESTS;
done_testing();

say join ', ', get_factorions();
say join ', ', get_factorions_1k();

cmpthese( 100, {
  '10' => sub { get_factorions()    },
  '1k' => sub { get_factorions_1k() },
});

## Has to be at most 7 digits as 8x9! < 9_999_999
## We note that 8x9^7 is the maximum possible value
## Further the value of this is 2_540_160. So we note
## that the maxium value is 2 + 6*9! or 2_177_282.
##
## So we are guaranteed to find all values if we
## search as far as this value...

## In the 1k method - we cheat and store the sum of 3 factorials for values
## from 0..999 {along with 2 digit version 0..99 and the previously used 0..9}
## We have to do this as the sum of "99" isn't the same as the sum "099".

sub get_factorions {
  @f = (1);
  push @f, $_*$f[-1] foreach 1..9;

  my @res;
  is_factorion($_) && push @res,$_ for 1 .. 2_177_282;
  return @res;
}

sub is_factorion {
  my $t = $_[0];
  ($t-=$f[$_])||return 1 for split //,$t;
  return 0;
}

sub get_factorions_1k {
  @f = (1);
  push @f, $_*$f[-1] foreach 1..9;
  @t = map { my $t = $_; map {$t+$_} @f } @f;
  @q = map { my $t = $_; map {$t+$_} @f } @t;
  my @res;
  is_factorion_1k($_) && push @res,$_ for 1 .. 2_177_282;
  return @res;
}

sub is_factorion_1k {
  my $t = $_[0];
  return $t == (
      $t >= 1e6 ? $f[ $t/1e6 ] + $q[ ($t/1e3)%1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e5 ? $q[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e4 ? $t[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e3 ? $f[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 100 ? $q[ $t ]
    : $t >=  10 ? $t[ $t ]
    :             $f[ $t ]
  );
}

