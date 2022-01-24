#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Time::HiRes qw(time);

my @MAP = ( 0..9,'A'..'Z' );

## Format output so I can paste it straight into github markup...
say '|  N | v         | v^2                | v^2 (base N)    | Time      | Evals    |';
say '| -: | --------: | -----------------: | --------------: | --------: | -------: |';

for my $N (2..15) {
  my $time = time;
  my ($v,$c) = biggest_perfect_square($N);
  say sprintf '| %2d | %9d | %18d | %15s | %9.6f | %8d |',
         $N, $v, $v*$v, baseN($v*$v,$N), time-$time, $c;
}

## We brute force this - we start at the largest possible square.
## and work backwards - our guess at the largest is the square
## root of the largest possible value with $N digits or roughty
## $N**($N/2);

## Rather than generating a representation of the number we
## just look for repeated digits - if we find one we test the
## next number - note here we use the "next LABEL" to break
## out of both the while and the for loop

sub biggest_perfect_square {
  my $nt = my $m = (my $n = shift) -1;
  $m=$m*$n+$nt while $nt--;
  O: for( my $tn = my $t = int sqrt $m; $t; $t -- ) {
    my ($q,%seen) = $t**2;
    $seen{$q%$n}++?(next O):($q=int($q/$n)) while $q;
    return($t,$tn-$t+1);
  }
}

## As we didn't generate earlier - to prove we have a
## candidate we convert the number into base $N...
## We use the same while loop as above to return the
## string.

sub baseN {
  my($o,$v,$n) = ('',@_);
  ($o,$v) = ( $MAP[$v%$n].$o, int ($v/$n) ) while $v;
  $o;
}
