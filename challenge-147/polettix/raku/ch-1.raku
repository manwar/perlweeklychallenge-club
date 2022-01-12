#!/usr/bin/env raku
use v6;

sub MAIN (Int:D $n = 20, :$exclusive = False) {
   $exclusive ?? exclusive($n) !! constructive($n);
}


sub constructive ($n) { put nth-left-truncatable($_) for 1 .. $n }

sub nth-left-truncatable ($nth) {
   state @cache = (10..99).grep({ .is-prime && .substr(1, 1).is-prime });
   state $prefix = 1;
   state $first-id = 0;
   state $next-first-id = @cache.elems;
   state $id = $first-id;
   while @cache < $nth { # find moar!
      my $candidate = ($prefix ~ @cache[$id++]).Int;
      @cache.push($candidate) if $candidate.is-prime;
      if $candidate.chars == @cache[$id].chars { # toppled over!
         if $prefix < 9 {
            ++$prefix;
         }
         else {
            $prefix = 1;
            ($first-id, $next-first-id) = ($next-first-id, $id);
         }
         $id = $first-id; # just reset the cursor
      }
   }
   return @cache[$nth - 1];
}


sub exclusive (Int:D $n is copy = 20) {
   my $i = 9;
   while $n > 0 {
      next unless is-left-truncatable($i = $i + 2);
      $i.put;
      --$n;
   }
}

sub is-left-truncatable ($n) {
   return False if $n < 10 || $n ~~ /0/;
   return False unless $n.is-prime;
   state %cache;
   if %cache{$n}:!exists {
      my $truncated = $n.substr(1);
      return $truncated.is-prime if $truncated < 10;
      %cache{$n} = is-left-truncatable($truncated);
   }
   return %cache{$n};
}
