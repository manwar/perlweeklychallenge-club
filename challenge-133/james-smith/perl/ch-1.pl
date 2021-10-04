#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 10, 3 ],
  [ 27, 5 ],
  [ 85, 9 ],
  [ 101, 10 ],
  [ 418529770, 20458 ],
);

is( find_root($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub find_root {
  my $n = shift;
  ## Make order of magnitude guess
  my ($l,$r) = (1 & length $n ) ? (       10 ** int(0.5*length $n),  3.2 * 10 ** int(0.5*length $n) )
                                : ( 0.3 * 10 ** int(0.5*length $n),        10 ** int(0.5*length $n) );
  while($r - $l > 1) {
    print "+";
    my $m = $l + int(( $r-$l)/2);
    if( $m*$m < $n ) {
      $l=$m;
    } else {
      $r=$m;
    }
  }
  return $l;
}

