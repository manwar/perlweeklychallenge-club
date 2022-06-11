#!/usr/bin/env raku

sub is-palindrome($num) {
  $_ ~~ .reverse given $num.comb.List
}

(^1000).grep: { .is-prime && .&is-palindrome } andthen .join: ', ' andthen .say;
