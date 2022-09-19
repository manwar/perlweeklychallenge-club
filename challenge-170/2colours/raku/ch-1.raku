#!/usr/bin/env raku

(1 .. *)
  .grep: &is-prime andthen
  [\*] $_ andthen
  .head: 10 andthen
  .pairs
  .map: { "P({.key + 1}) = {.value}" } andthen
  .join: "\n" andthen
  .say;

