#!/usr/bin/env raku

use v6.*;
my @n <== prompt 'Input: @n = ' andthen
  .comb: /\d+/;
my $i = prompt 'Input $i = ';
print 'Output: ';
@n
  .grep: * > $i andthen
  .join: ',' andthen
  say "($_)";
