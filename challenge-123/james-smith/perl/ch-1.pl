#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = @ARGV ? shift @ARGV : 1000;
my $C = @ARGV ? shift @ARGV : 2e5/$N; ## If 2nd par is 0 print value!

## For testing - uglies below 1000
########################################################################
my @UGLIES = qw(1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36 40
  45 48 50 54 60 64 72 75 80 81 90 96 100 108 120 125 128 135 144 150
  160 162 180 192 200 216 225 240 243 250 256 270 288 300 320 324 360
  375 384 400 405 432 450 480 486 500 512 540 576 600 625 640 648 675
  720 729 750 768 800 810 864 900 960 972 1000);

die nth_ugly_opt($N) unless $C; ## 2nd par 0..

my $c=0; my @TESTS = map { [ ++$c, $_ ] } @UGLIES; ## generate tests

is( nth_ugly_scan($_->[0]), $_->[1] ) foreach @TESTS;
is( nth_ugly(     $_->[0]), $_->[1] ) foreach @TESTS;
is( nth_ugly_opt( $_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

cmpthese(int $C,{
  'scan' => sub { nth_ugly_scan($N) },
  'orig' => sub { nth_ugly($N) },
  'opt'  => sub { nth_ugly_opt($N) },
});
#say  nth_ugly($N);

say  nth_ugly_opt($N);
## Largest ugly that perl can display as int (<2^64) is:
##  - Ugly_13282 - 18,432,000,000,000,000,000 = 2^26.3^2.5^15
## the next ugly Ugly_13283 is 2^64 (18,446,744,073,709,551,616)
## which perl can't represent in 64 bits... so gets evaluated
## as a floating point so the calculations no longer work correctly
## you could use big ints - but this would give an over head.

sub nth_ugly {
  my $n = shift;
  state @uglies = (1);
  while(1) {
    return $uglies[$n-1] if $n <= @uglies;
    ## Get the next ugly....
    my $next = 0;
    foreach my $l (5,3,2) {
      foreach(@uglies) {
        next if $_ * $l <= $uglies[-1];
        $next = $_*$l if !$next || $next > $_*$l;
        last;
      }
    }
    push @uglies, $next;
  }
}

sub nth_ugly_opt {
  my $n = shift;
  ## l2,l3,l5 - are the position in the uglies list corresponding to
  ## the next number which is multiple of 2,3,5 respectively - the
  ## value of this is v2,v3,v5....
  ## Initial values are 0,0,0 & 2,3,5....

  state $l2 = 0;
  state $l3 = 0;
  state $l5 = 0;
  state $v2 = 2;
  state $v3 = 3;
  state $v5 = 5;
  state @uglies = (1);

  return $uglies[$n-1] if $n <= @uglies; ## Check we don't already have the value...

  while( @uglies < $n ) { ## Until the array contains "n" uglies {we will return the last}
    ## Work out the next ugly...
    ## It's one of the 3 candidates v2, v3 or v5
    push @uglies, my $next = $v2<$v3 && $v2<$v5 ? $v2 : $v3<$v5 ? $v3 : $v5;
    $v2 = $uglies[++$l2]*2 if $v2 == $next; ## For whichever of v2, v3 or v5 (may be
    $v3 = $uglies[++$l3]*3 if $v3 == $next; ## more than one...) we look at the next
    $v5 = $uglies[++$l5]*5 if $v5 == $next; ## ugly in the list and multiple by 2,3 or 5.
  }
  return $uglies[-1];
}

sub nth_ugly_scan {
  state @uglies;
  my $n = shift;
  return $uglies[$n-1] if $n <= @uglies;
  my $c = $n;
  my $r = 0;
  while(1) {
    next unless is_ugly(++$r);
    return $uglies[$n-1] = $r unless --$c;
  }
}

sub is_ugly {
  my $v = shift;
  state %cache;
  return $cache{$v} if exists $cache{$v};
  $v >>=1 until $v & 1;
  $v /= 3 until $v % 3;
  $v /= 5 until $v % 5;
  return $cache{$v} = $v == 1;
}

