#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);


my $N = 1000;
my @primes      = (2);
my @semi_primes = (4);

foreach my $p ( map { 1+2*$_ } 1..($N/4) ) {
  map { ($p%$_)||(next) } @primes;
  push @primes,$p;
  push @semi_primes,grep {$_<=$N} map{$p*$_} @primes;
}

say for sort {$a<=>$b} @semi_primes;

