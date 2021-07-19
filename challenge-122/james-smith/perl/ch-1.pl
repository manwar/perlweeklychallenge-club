#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @stream = map {$_*10} 1..50;

say stream_average($_) foreach @stream;

sub stream_average {
  state($n,$t);
  $n++; $t+=shift;
  return $t/$n;
}

