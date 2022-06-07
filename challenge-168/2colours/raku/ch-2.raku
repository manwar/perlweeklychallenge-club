#!/usr/bin/env raku

multi prime-factors(Int() $num) { samewith $num, 1 }
multi prime-factors(1, $) { () }
multi prime-factors($num where *.&is-prime, $) { ($num, ) }
multi prime-factors($num is copy, $lower-bound) {
  my $first-factor = ($lower-bound ^.. *).first: $num %% *;
  my $first-exponent = 0;
  while $num %% $first-factor {
    $first-exponent++;
    $num div= $first-factor;
  }
  |($first-factor xx $first-exponent), |prime-factors($num, $first-factor)
}

multi home-prime($num where *.&is-prime) { $num }
multi home-prime($num) { samewith [~] prime-factors $num}

my $n = prompt 'N = ';
say home-prime($n);