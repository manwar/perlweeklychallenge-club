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
my @b = map { my $t = $_; map {$t+$_} @f }
my @a = map { my $t = $_; map {$t+$_} @f }
my @z = map { my $t = $_; map {$t+$_} @f }
my @q = map { my $t = $_; map {$t+$_} @f }
my @t = map { my $t = $_; map {$t+$_} @f } @f;

my @TESTS = ( [ 145, 1 ], [ 125, 0 ], );
is( is_factorion(    $_->[0])||0, $_->[1] ) foreach @TESTS;
is( is_factorion_10k( $_->[0])||0, $_->[1] ) foreach @TESTS;
done_testing();

say join ', ', get_factorions();
say join ', ', get_factorions_10k();

cmpthese( 100, {
  '10'   => sub { get_factorions()    },
  '10k'  => sub { get_factorions_10k() },
});

## Has to be at most 7 digits as 8x9! < 9_999_999
## We note that 8x9^7 is the maximum possible value
## Further the value of this is 2_540_160. So we note
## that the maxium value is 2 + 6*9! or 2_177_282.
##
## So we are guaranteed to find all values if we
## search as far as this value...

## In the 10k method - we cheat and store the sum of 3 factorials for values
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

sub get_factorions_10k {
  @f = (1);
  push @f, $_*$f[-1] foreach 1..9;
  @z = map { my $t = $_; map {$t+$_} @f }
  @q = map { my $t = $_; map {$t+$_} @f }
  @t = map { my $t = $_; map {$t+$_} @f } @f;
  my @res;
  is_factorion_10k($_) && push @res,$_ for 1 .. 2_177_282;
  return @res;
}

sub is_factorion_10k {
  my $t = $_[0];
  return $t == (
      $t >= 1e6 ? $z[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e5 ? $q[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e4 ? $t[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e3 ? $z[ $t     ]
    : $t >= 100 ? $q[ $t     ]
    : $t >=  10 ? $t[ $t     ]
    :             $f[ $t     ]
  );
}

