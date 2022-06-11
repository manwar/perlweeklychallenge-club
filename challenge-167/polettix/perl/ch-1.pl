#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use File::Basename 'dirname';
use lib dirname(__FILE__) . '/local/lib/perl5';

use ntheory qw< next_prime is_prime >;

my $n = shift // 10;
my @retval;
my $candidate = 100;
while ($n > 0) {
   $candidate = next_prime($candidate);
   next unless is_circular_prime($candidate);
   push @retval, $candidate;
   --$n;
}

say join ', ', @retval;

sub is_circular_prime ($x) {
   my $initial = $x;
   for (2 .. length $x) {
      return !!0 unless is_prime($x);
      $x = substr($x, 1) . substr($x, 0, 1);
      return !!0 if $x < $initial;
   }
   return is_prime($x);
}
