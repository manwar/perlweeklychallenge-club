#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [       1,     0 ],
  [       3,     1 ],
  [       5,     2 ],
  [      10,     4 ],
  [      15,     6 ],
  [      25,     9 ],
  [   1_000,   168 ],
  [ 100_000, 9_592 ],
);


is( n_primes_compact( $_->[0] ), $_->[1] ) for @TESTS;
is( n_primes_fast(    $_->[0] ), $_->[1] ) for @TESTS;
done_testing();

cmpthese( -10, {
  'compact' => sub { n_primes_compact( $_->[0] ) for @TESTS },
  'fast'    => sub { n_primes_fast(    $_->[0] ) for @TESTS },
} );

sub n_primes_compact { # for all tests 9.28 seconds
  return 0if(my$n=shift)<3;
  @_=2;
  //,(grep{($'%$_)||next}@_),push@_,$_ for 3..$n-1;
  1*@_
}

sub n_primes_fast { # for all tests 0.066 seconds
  return 0 if (my $n=shift) <3;
  my @p = (my $q=2);
  O: for( my $i=3; $i<$n; $i+=2 ) {
    $q++ if $i>$q*$q;
    for(@p) {
      next O unless $i%$_;
      last if $_>$q;
    }
    push @p, $i;
  }
  scalar @p
}

