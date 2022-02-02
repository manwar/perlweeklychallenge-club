#!/usr/bin/env raku

use experimental :cached;
my $*a, my $*b;

multi fibo-word(1) { $*a }
multi fibo-word(2) { $*b }
multi fibo-word($n where * > 2) is cached { fibo-word($n-2) ~ fibo-word($n-1) }

sub MAIN(
  Str $*a, #= the first starting value of the Fibonacci Word sequence
  Str $*b #= the second starting value of the Fibonacci Word sequence, having equal length to $a
  where { $*a.chars == $*b.chars }
) {
  my $first-long = (1..*).map(&fibo-word).first(*.chars >= 51);
  say "The 51st digit in the first term having at least 51 digits '$_' is {.comb[50]}." given $first-long;
}
