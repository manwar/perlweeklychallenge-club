#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(ds([1,2,5,3,4],[4,6,7,8,9]),0,'example 1');
is(ds([1,3,5,7,9],[0,2,4,6,8]),1,'example 2');

sub ds {
  my ($a,$b)=@_;
  my %h=map {$_ => 1} @{$a};
  foreach my $n (@{$b}) {
    if (exists $h{$n}) {
      return 0;
    }
  }
  return 1;
}
