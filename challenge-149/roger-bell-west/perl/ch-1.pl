#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is_deeply(fds(8),[0, 1, 2, 3, 5, 8, 10, 11],'example 1');
is_deeply(fds(20),[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44],'example 2');
is_deeply(fds(61),[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44, 49, 50, 53, 58, 62, 67, 71, 76, 80, 85, 94, 100, 101, 102, 104, 107, 110, 111, 113, 116, 120, 122, 125, 131, 134, 139, 140, 143, 148, 152, 157, 161, 166, 170, 175, 184, 193, 200, 201, 203, 206],'example 3');

sub fds {
  my $n=shift;
  my @o;
  my @f=(1,0);
  my %ft=map {$_ => 1} @f;
  my $k=0;
  while (scalar @o < $n) {
    my $ds=0;
    my $j=$k;
    while ($j > 0) {
      $ds += ($j % 10);
      $j=int($j/10);
    }
    while ($f[0] < $ds) {
      @f=($f[1]+$f[0],$f[0]);
      $ft{$f[0]}=1;
    }
    if (exists $ft{$ds}) {
      push @o,$k;
    }
    $k++;
  }
  return \@o;
}
