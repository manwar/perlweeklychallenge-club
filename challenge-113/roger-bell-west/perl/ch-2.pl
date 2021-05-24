#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(rbt([1,2,3,4,-1,5,6,-1,7]),[27,26,25,24,-1,23,22,-1,21],'example 1');

sub rbt {
  my $ti=shift;
  my $s=0;
  foreach my $n (@{$ti}) {
    if ($n>=0) {
      $s+=$n;
    }
  }
  my @to;
  foreach my $n (@{$ti}) {
    if ($n>=0) {
      push @to,$s-$n;
    } else {
      push @to,$n;
    }
  }
  return \@to;
}
