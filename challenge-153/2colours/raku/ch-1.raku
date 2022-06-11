#!/usr/bin/env raku

sub left-factorial($n) {
  [+] (^$n).map({[*] (1..$_)})
}

(1..10).map(&left-factorial).join(', ').say;
