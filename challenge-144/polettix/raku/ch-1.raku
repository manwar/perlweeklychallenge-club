#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $limit where * > 0 = 100) {
   semiprimes-upto-constructive-tight($limit).join(', ').put;
   semiprimes-upto-constructive-flow($limit).join(', ').put;
   semiprimes-upto-deconstruct($limit).join(', ').put;
}

sub semiprimes-upto-constructive-tight ($limit) {
   my @ps = (2 .. 1 + ($limit / 2).Int).grep: *.is-prime;
   my @retval;
   for ^@ps -> $li {
      my $n-start = @retval.elems;
      for $li ..^ @ps -> $hi {
         my $prod = @ps[$li] * @ps[$hi];
         last if $prod > $limit;
         @retval.push: $prod;
      }
      last if @retval.elems == $n-start;
   }
   return @retval.sort;
}

sub semiprimes-upto-constructive-flow ($limit) {
   my @ps = (2 .. 1 + ($limit / 2).Int).grep: *.is-prime;
   (@ps X @ps) # consider all pairs of those primes
      .grep({$_[0] <= $_[1]}) # DRY
      .map({[*] @$_})         # multiply them
      .grep({$_ <= $limit})   # stay within the limit
      .sort;                  # format and cook
}

sub semiprimes-upto-deconstruct ($limit) {
   my @ps;
   gather for 2 .. $limit -> $candidate {
      if $candidate.is-prime { @ps.push: $candidate }
      else {
         for @ps -> $prime {
            next unless $candidate %% $prime;
            my $other = ($candidate / $prime).Int;
            take $candidate if ($other >= $prime) && $other.is-prime;
         }
      }
   };
}
