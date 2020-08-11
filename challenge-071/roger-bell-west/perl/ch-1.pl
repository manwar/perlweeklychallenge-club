#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(shuffle);
use Test::More tests => 2;

is_deeply(peaks(18, 45, 38, 25, 10, 7, 21, 6, 28, 48),
          [45, 21, 48],
          'peaks 1',
            );

is_deeply(peaks(47, 11, 32, 8, 1, 9, 39, 14, 36, 23),
          [47, 32, 39, 36],
          'peaks 2',
            );

sub genseq {
  my $n=shift;
  my @out=shuffle(1..50);
  splice @out,$n;
  return @out;
}

sub peaks {
  my @list=@_;
  my @out;
  foreach my $n (0..$#list) {
    if (($n==0 || $list[$n]>$list[$n-1])
          &&
          ($n==$#list || $list[$n]>$list[$n+1])) {
      push @out,$list[$n];
    }
  }
  return \@out;
}
