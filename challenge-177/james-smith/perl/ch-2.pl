#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Math::Prime::Util qw(is_prime);
use Time::HiRes qw(time);

my $K = $ARGV[0]//20;
my $t0 = time;
my($i,$t)=0;
for(1..$K) {
  is_prime( $t = (++$i).'0'.(reverse $i) ) ? say $t : redo;
}
warn time - $t0;

$t0 = time;
my $m = 1;
my $c = $K;
O: while(1) {
  for my $f (1,3,5,7,9) {
    is_prime( $_.='0'.reverse$_ ) && ( $c-- ? say : last O ) for $f*$m .. ($f+1)*$m-1;
  }
  $m *= 10;
}
warn time-$t0;
