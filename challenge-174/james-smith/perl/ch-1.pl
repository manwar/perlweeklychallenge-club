#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Time::HiRes qw(time);

my $n = -1, my $t0 = time;
for(1..19) {
  my($c,$t) = (0,++$n);
  $t-= $_ ** ++ $c for split //,$n;
#  say "                      $n - $t";
  $t ? (redo) : say sprintf ' %2d %8d %10.6f', $_, $n, time-$t0;
}

$n = -1;
say for map { while(1) { my($c,$t)=(0,++$n);
                         $t-=$_**++$c for split//,$n;
                         $t || last
                       }; $n } 1..19;
