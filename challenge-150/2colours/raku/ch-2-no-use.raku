#!/usr/bin/env raku

constant $limit = 500;
constant @base-primes = (1..sqrt $limit).grep(&is-prime);
sub prime-factors($n is copy where 0 < * <= $limit) {
  gather {
    for @base-primes {
      while $n %% $_ {
        .take;
        $n /= $_;
      }
    }
    take $n unless $n == 1;
  }
}
say "The smallest positive square-free integers are\n\t{(1..500).grep(*.&prime-factors.Bag.values.all < 2).join(', ')}";
