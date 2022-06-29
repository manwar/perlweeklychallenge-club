#!/usr/bin/env raku

sub compose(&f, &g) {
  sub (|args) { f(g(|args)) }
}

[* * 3, &infix:<+>].reduce(&compose)(3, 4).say;