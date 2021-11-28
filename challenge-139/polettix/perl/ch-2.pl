#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
my $N = shift || 5;
my $p = 2;
while ($N > 0) {
   if (is_long_prime($p)) {
      say $p;
      --$N;
   }
   $p++;
}
sub is_prime ($n) {
   for (2 .. sqrt $n) { return unless $n % $_ }
   return 1;
}
sub is_long_prime ($n) {
   return unless (10 % $n) && is_prime($n);
   my $num = 1 . '0' x length($n);
   my %seen;
   $num = 10 * ($num % $n) while ! $seen{$num}++;
   return $n - 1 == scalar keys %seen;
}
