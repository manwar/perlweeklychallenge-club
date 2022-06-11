#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(leftfactorial(10),[1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114],'example 1');

sub leftfactorial {
  my $mx = shift;
  my @out;
  my $fact=1;
  my $sum=0;
  foreach my $i (0..$mx-1) {
    if ($i>0) {
      $fact *= $i;
    }
    $sum += $fact;
    push @out,$sum;
  }
  return \@out;
}
