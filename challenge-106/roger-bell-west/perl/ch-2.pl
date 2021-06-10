#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(ds(1,3),"0.(3)",'example 1');
is(ds(1,2),"0.5",'example 2');
is(ds(5,66),"0.0(75)",'example 3');

sub ds {
  my $n=shift;
  my $d=shift;
  my $quotient=sprintf('%d.',$n/$d);
  my $c=10*($n % $d);
  while ($c > 0 && $c < $d) {
    $c *= 10;
    $quotient .= "0";
  }
  my @digits;
  my %passed;
  my $i=0;
  while (1) {
    if (exists $passed{$c}) {
      my @cycle=@digits[$passed{$c}..$#digits];
      my $result=$quotient . join('',@digits[0..$passed{$c}-1]);
      if (scalar @cycle > 1 || $cycle[0] != 0) {
        $result .= '('.join('',@cycle).')';
      }
      if (substr($result,-1,1) eq '.') {
        substr($result,-1,1)='';
      }
      return $result;
    }
    my $q=int($c/$d);
    my $r=$c % $d;
    $passed{$c}=$i;
    push @digits,$q;
    $i++;
    $c=10*$r;
  }
}
