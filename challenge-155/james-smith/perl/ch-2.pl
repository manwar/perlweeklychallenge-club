#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

printf "%4d %8d\n", $_,pisano_period( $_ ) for 1..(@ARGV?$ARGV[0]:144);

sub pisano_period {
  return 1 if $_[0]==1;              ## Special case $n==1 sequence is just "0"
  my ($n,$c,$p,$q) = (shift,2,1,1);
  $c++,($p,$q)=($q,($p+$q)%$n) while $q || $p!=1; ## End of sequence ($p,$q)=(1,0)
  return $c;
}

