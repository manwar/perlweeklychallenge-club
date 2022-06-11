#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

use List::Util qw(reduce);

is_deeply(pythagoreanmeans([1,3,5,7,9]),
          {
            AM => 5.0, GM => 3.9, HM => 2.8},
          'example 1');

is_deeply(pythagoreanmeans([2,4,6,8,10]),
          {
            AM => 6.0, GM => 5.2, HM => 4.4},
          'example 2');

is_deeply(pythagoreanmeans([1,2,3,4,5]),
          {
            AM => 3.0, GM => 2.6, HM => 2.2},
          'example 3');

sub pythagoreanmeans {
  my $s=shift;
  return {
    AM => round1(arithmeticmean($s)),
    GM => round1(geometricmean($s)),
    HM => round1(harmonicmean($s)),
  };
}

sub round1 {
  my $x=shift;
  return int(10*$x+0.4999999)/10;
}
      
sub arithmeticmean {
  my $s=shift;
  return (reduce { $a + $b} @{$s})/(scalar @{$s});
}

sub geometricmean {
  my $s=shift;
  return (reduce { $a * $b} @{$s}) ** (1/scalar @{$s});
}

sub harmonicmean {
  my $s=shift;
  return (scalar @{$s}) / (reduce { $a + 1/$b} 0,@{$s});
}
