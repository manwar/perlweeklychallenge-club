#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use ntheory 'is_prime';

my $n = shift // 20;
my $it = cyclop_prime_factory();
say $it->() for 1 .. $n;

sub cyclop_prime_factory {
   my $n = 0;
   return sub {
      while ('necessary') {
         ++$n;
         $n =~ tr/0/1/;
         $n = ($1 + 1) . $2 if $n =~ m{\A ([2468]) (.*) }mxs;
         my $candidate = $n . '0' . reverse($n);
         return $candidate if is_prime($candidate);
      }
   };
}
