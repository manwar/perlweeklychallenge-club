#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my %primes = map { $_ => 1 } 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37;

my$n=0;

$n++, exists $primes{(sprintf '%b', $n)=~tr/1/1/} ? (say $n) : redo for 1..100;

