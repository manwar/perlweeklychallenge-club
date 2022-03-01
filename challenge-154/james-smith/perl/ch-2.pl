#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Time::HiRes qw(time);

my @primes = (2,3);
my $p = 3;

my $p0 = my $p1 = my $p2 = 1;
my $c = 10;
my $t0 = time;
T: while($c) {
  ($p0,$p1,$p2)=($p1,$p2,$p0+$p1);
  next if $p2 == $p1;
  O: for( ;$primes[-1]*$primes[-1]<$p2;$p+=2) {
    $_*$_ > $p2 ? last : $p%$_ || next O for @primes;
    push @primes, $p;
  }
  $p2%$_ || $_>=$p2 || next T for @primes;
  say sprintf '%11.6f %20d', -$t0+($t0=time), $p2;
  $c--;
}

