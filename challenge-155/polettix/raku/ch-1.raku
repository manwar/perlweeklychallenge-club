#!/usr/bin/env raku

sub MAIN (Int:D $n = 8) {
   first-fortunate-numbers($n).join(', ').put;
   return 0;
}

sub first-fortunate-numbers($n) {
   my &it = fortunate-numbers-it();
   my @cleared;
   my @seen;
   while @cleared < $n {
      my ($prime, $fn) = &it();
      @seen = (@seen.Slip, $fn).sort.unique;
      @cleared.push: @seen.shift while @seen && @seen[0] < $prime;
   }
   return @cleared[^$n];
}

sub fortunate-numbers-it() {
   my $primorial = 1;
   my &pit = primes-it();
   return sub {
      my $prime = &pit();    # get next prime
      $primorial *= $prime;  # update the primorial
      return 2, 3 if $prime == 2;
      my $n = $prime;
      loop {
         $n += 2;
         return $prime, $n if ($primorial + $n).is-prime;
      }
   }
}

sub primes-it() {
   my @cache = 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47;
   my $last;
   return sub {
      return $last = @cache.shift if @cache;
      loop {
         $last += 2;
         return $last if $last.is-prime;
      }
   }
}
