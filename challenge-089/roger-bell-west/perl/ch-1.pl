#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(gs(3),3,'example 1');
is(gs(4),7,'example 2');

use List::Util qw(min sum);

sub gs {
  my $n=shift;
  my $tot=$n-1; # gcd(1,2)+gcd(1,3)+...+gcd(1,n)
  foreach my $a (2..$n-1) {
    $tot+=sum(map {gcd($a,$_)} ($a+1..$n));
  }
  return $tot;
}

sub gcd {
  my ($a,$b)=@_;
  if ($a==0) {
    return $b;
  }
  if ($b==0) {
    return $a;
  }
  my $d=0;
  while (1) {
    if ($a == $b) {
      return $a << $d;
    }
    my $aa=($a % 2 == 0);
    my $bb=($b % 2 == 0);
    if ($aa && $bb) {
      $a >>= 1;
      $b >>= 1;
      $d++;
    } elsif ($aa) {
      $a >>= 1;
    } elsif ($bb) {
      $b >>= 1;
    } else {
      my $c=abs($a-$b);
      $a=min($a,$b);
      $b=$c >> 1;
    }
  }
}
