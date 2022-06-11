#!/usr/bin/env raku

constant \minus-one = -1;

multi möbius(1 --> 1) {}
multi möbius($n where { .is-prime } --> minus-one) {}
multi möbius($n) {
  my $divisor = (2..^$n).first($n %% *);
  my $quotient = $n div $divisor;
  $quotient %% $divisor ?? 0 !!  möbius($divisor) * möbius($quotient)
}


my $n = prompt 'Input: $n = ';
say "Output: {möbius($n)}";
