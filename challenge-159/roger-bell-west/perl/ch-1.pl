#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;
use List::Util qw(reduce);

is_deeply(farey(5),[
  [0, 1], [1, 5], [1, 4], [1, 3], [2, 5], [1, 2], [3, 5], [2, 3],
  [3, 4], [4, 5], [1, 1]
    ],'example 1');

is_deeply(farey(7),[
  [0, 1], [1, 7], [1, 6], [1, 5], [1, 4], [2, 7], [1, 3], [2, 5],
  [3, 7], [1, 2], [4, 7], [3, 5], [2, 3], [5, 7], [3, 4], [4, 5],
  [5, 6], [6, 7], [1, 1]
    ],'example 2');

is_deeply(farey(4),[
  [0, 1], [1, 4], [1, 3], [1, 2], [2, 3], [3, 4], [1, 1]
    ],'example 3');

sub gcd {
  my ($m,$n)=@_;
  while ($n!=0) {
    ($m,$n)=($n,$m % $n);
  }
  return $m;
}

sub lcm {
  my ($m,$n)=@_;
  return $m/gcd($m,$n)*$n;
}

sub lcmseries {
  my $s=shift;
  return reduce {lcm($a,$b)} @{$s};
}

sub farey {
  my $n=shift;
  my $l=lcmseries([2..$n]);
  my %d;
  foreach my $i (1..$n) {
    my $m=$l/$i;
    foreach my $j (0..$i) {
      my $k=$m*$j;
      unless (exists $d{$k}) {
        $d{$k}=[$j,$i];
      }
    }
  }
  return [map {$d{$_}} sort {$a <=> $b} keys %d];
}
