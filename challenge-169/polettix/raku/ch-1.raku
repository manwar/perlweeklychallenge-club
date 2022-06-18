#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $limit where * > 0 = 20) {
   my $length = 1;
   my @brilliants;
   while @brilliants < $limit {
      @brilliants.push: pairs-products(primes-of-length($length++)).Slip;
   }
   put @brilliants[0 ..^ $limit].join(', ');
}

sub pairs-products (@ns) {
   (@ns X @ns).grep({[<=] $_}).map({[*] $_}).sort;
}

sub primes-of-length (Int:D $n where * > 0) {
   my $lo = [*] 10 xx ($n - 1);
   ($lo .. $lo * 10).grep({.is-prime}).Array;
}
