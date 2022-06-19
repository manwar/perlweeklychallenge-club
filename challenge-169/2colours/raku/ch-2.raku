#!/usr/bin/env raku

sub is-achilles($num) {
  (powerful-exponent($num) // 0) == 1
}

multi powerful-exponent(1 --> 0) {}
multi powerful-exponent($ where *.is-prime --> Nil) {}
multi powerful-exponent($num) {
  my $first-divisor = (2 .. *).first: $num %% *;
  my $first-exponent = (1 .. *).toggle($num %% $first-divisor ** *).tail;
  return Nil if $first-exponent == 1;
  return $first-exponent gcd $_ with powerful-exponent($num div $first-divisor ** $first-exponent);
  Nil
}

(1 .. *).grep: &is-achilles
  andthen .head: 20
  andthen .join: ', '
  andthen .say;