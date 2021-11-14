#! /usr/bin/perl

use strict;

use Test::More tests => 2;

is(on([2,5,4,4,5,5,2]),5,'example 1');
is(on([1,2,3,4,3,2,1,4,4]),4,'example 2');

sub on {
  my ($list)=@_;
  my %k;
  foreach my $n (@{$list}) {
    if (exists $k{$n}) {
      delete $k{$n};
    } else {
      $k{$n}=1;
    }
  }
  return (keys %k)[0];
}
