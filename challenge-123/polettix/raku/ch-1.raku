#!/usr/bin/env raku
use v6;

# check that $x is of the form 2^x * 3^y * 5^z
sub is-ugly (Int() $k is copy) {
   # remove all 2, 3, and 5 factors in $k
   for 2, 3, 5 -> $d {
      $k /= $d while $k %% $d;
   }

   # if we're left with anything that's not 1, the number is *not* ugly
   return $k == 1;
}

sub ugly-number-at-position (Int:D $n where * > 0) {
   # keep a cache of values for fun and profit
   state @cache = 1 .. 6;

   # We add elements to the cache as we need them, otherwise leveraging
   # previous calculations
   while $n > @cache.elems {
      # we start testing immediately after the latest element we put
      my $c = 1 + @cache[*-1];

      # anything that yields a rest when divided by 2 and by 3 and by 5
      # is not ugly and gets us to look for the next candidate
      $c++ until is-ugly($c);

      # our candidate $c is divisible by one of 2, 3, or 5, so it's
      # "ugly" and we add it to the lot, in order
      @cache.push: $c;
   }

   # our input $n has an off-by-one difference from how we index arrays
   return @cache[$n - 1];
}

sub MAIN (Int $n = 8) { put ugly-number-at-position($n) }
