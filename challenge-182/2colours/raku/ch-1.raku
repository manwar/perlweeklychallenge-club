#!/usr/bin/env raku

my @n <==
  prompt 'Input: @n = ' andthen
  .comb: / \d+ /;
print 'Output: ';
@n andthen
  .first: .max, :k andthen
  .say;
