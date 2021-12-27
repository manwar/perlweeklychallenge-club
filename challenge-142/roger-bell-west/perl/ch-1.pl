#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(dld(24,2),2,'example 1');
is(dld(30,5),2,'example 2');

sub factor {
  my $n=shift;
  if ($n==1) {
    return [1];
  }
  my @ff;
  my $s=int(sqrt($n));
  if ($s*$s == $n) {
    push @ff,$s;
    $s--;
  }
  foreach my $pf (2..$s) {
    if ($n % $pf == 0) {
      unshift @ff,$pf;
      push @ff,$n/$pf;
    }
  }
  unshift @ff,1;
  push @ff,$n;
  return \@ff;
}

sub dld {
  my ($m,$n)=@_;
  return scalar grep {$_ % 10 == $n} @{factor($m)};
}
