#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say nth_left_truncatable($_) for 1 .. shift // 20;

sub nth_left_truncatable ($nth) {
   state $cache = [ grep { is_prime($_) && is_prime(substr $_, 1) } 10 .. 99 ];
   state $prefix = 1;
   state $first_id = 0;
   state $next_first_id = $cache->@*;
   state $id = $first_id;
   while ($cache->@* < $nth) {
      my $candidate = $prefix . $cache->[$id++];
      push $cache->@*, $candidate if is_prime($candidate);
      if (length($candidate) == length($cache->[$id])) { # toppled over!
         if ($prefix < 9) {
            ++$prefix;
         }
         else {
            $prefix = 1;
            ($first_id, $next_first_id) = ($next_first_id, $id);
         }
         $id = $first_id; # just reset the cursor
      }
   }
   return $cache->[$nth - 1];
}

sub is_prime { # https://en.wikipedia.org/wiki/Primality_test
   return if $_[0] < 2;
   return 1 if $_[0] <= 3;
   return unless ($_[0] % 2) && ($_[0] % 3);
   for (my $i = 6 - 1; $i * $i <= $_[0]; $i += 6) {
      return unless ($_[0] % $i) && ($_[0] % ($i + 2));
   }
   return 1;
}
