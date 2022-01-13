#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $limit = shift // 100;
say join ', ', semiprimes_upto_constructive_tight($limit);

sub semiprimes_upto_constructive_tight ($limit) {
   my @ps = primes_upto(1 + $limit / 2);
   my @retval;
   for my $li (0 .. $#ps) {
      my $n_start = @retval;
      for my $hi ($li .. $#ps) {
         my $prod = $ps[$li] * $ps[$hi];
         last if $prod > $limit;
         push @retval, $prod;
      }
      last if @retval == $n_start;
   }
   return sort { $a <=> $b } @retval;
}

sub primes_upto ($n) {
   return if $n < 2;
   my @ps = 2;
   my $candidate = 3;
   CANDIDATE:
   while ($candidate <= $n) {
      for my $p (@ps) { next CANDIDATE unless $candidate % $p }
      push @ps, $candidate;
   }
   continue { $candidate += 2 }
   return @ps;
}
