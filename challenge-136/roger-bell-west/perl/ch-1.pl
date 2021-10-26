#! /usr/bin/perl

use strict;

use Test::More tests => 4;

is(twofriendly(8,24),1,'example 1');
is(twofriendly(26,39),0,'example 2');
is(twofriendly(4,10),1,'example 3');
is(twofriendly(1,2),0,'example 4');

sub gcd {
  my ($m,$n)=@_;
  while ($n!=0) {
    ($m,$n)=($n,$m % $n);
  }
  return $m;
}

sub ispower2 {
  my $n=shift;
  if ($n<2) {
    return 0;
  }
  return ($n & ($n-1))==0;
}

sub twofriendly {
  my ($m,$n)=@_;
  return ispower2(gcd($m,$n))?1:0;
}
