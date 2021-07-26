#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @uglies = qw(1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36 40 45 48 50 54 60 64 72 75 80 81 90 96 100 108 120 125 128 135 144 150 160 162 180 192 200 216 225 240 243 250 256 270 288 300 320 324 360 375 384 400 405 432 450 480 486 500 512 540 576 600 625 640 648 675 720 729 750 768 800 810 864 900 960 972 1000);

my $c=0;
my @TESTS = map { [ ++$c, $_ ] } @uglies;

is( nth_ugly($_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

sub nth_ugly {
  my $n = shift;
  state @uglies;
  @uglies=(1) unless @uglies;
  while(1) {
    return $uglies[$n-1] if $n <= @uglies;
    ## Get the next ugly....
    my $next = 0;
    foreach my $n (5,3,2) {
      foreach(@uglies) {
        next if $_ * $n <= $uglies[-1];
        $next = $_*$n if !$next || $next > $_*$n;
        last;
      }
    }
    push @uglies, $next;
  }
}

