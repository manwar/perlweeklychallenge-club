#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use ntheory qw< next_prime >;

my $limit = shift // 20;
my $it = primes_by_length_it();
my @brilliants;
while (@brilliants < $limit) {
   push @brilliants, pairs_products($it->());
}
say join ', ', @brilliants[0 .. ($limit - 1)];

sub pairs_products (@ns) {
   my @products;
   for my $i (0 .. $#ns) {
      for my $j ($i .. $#ns) {
         push @products, $ns[$i] * $ns[$j];
      }
   }
   return sort { $a <=> $b } @products;
}

sub primes_by_length_it {
   my $carry = 2;
   my $length = 1;
   return sub {
      my @retval;
      while (length($carry) == $length) {
         push @retval, $carry;
         $carry = next_prime($carry);
      }
      ++$length;
      return @retval;
   };
}
