#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

## Pre-populate cache with first 3 values...
my %cache = (
 1 => [1],
 2 => ['1 1',2],
 3 => ['1 1 1','1 2','2 1',3],
);
say join "\n",@{pts(4)};
say "";
say join "\n",@{pts(5)};

sub pts {
  my $n = shift;
  return [] if $n < 1;
  return $cache{$n} if exists $cache{$n};
  my @res = (
    map( {"1 $_"} @{pts($n-1)} ),
    map( {"2 $_"} @{pts($n-2)} ),
    map( {"3 $_"} @{pts($n-3)} )
  );
  return $cache{$n} = \@res;
}

