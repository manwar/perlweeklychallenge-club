#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @primes = (2,3,5,7,11,13);
my @vals;

##
## We know that all such numbers must have the form:
##   p^3.q, p.q.r
## where p, q, r are all primes...
##
## We therefore constuct all such combinations of the primes <= 13
## this should include the 10 numbers we are looking for!

while(@primes) {
  my $p1 = shift @primes;
  my @t  = @primes;
  while( @t ) {
    my $p2 = shift @t;
    push @vals, $p1*$p2*$p2*$p2, $p2*$p1*$p1*$p1, map {$p1*$p2*$_} @t;
  }
}

say join "\n",(sort{$a<=>$b}@vals)[0..9];

