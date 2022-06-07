#!/usr/bin/env raku

my @perrin-seq = 3, 0, 2, { $^c; $^a + $^b } ... *;
my @result <==
  @perrin-seq.grep: &is-prime
  andthen .unique.head: 13
  andthen .sort;
say "f(13) = [{@result.join: ', '}]";