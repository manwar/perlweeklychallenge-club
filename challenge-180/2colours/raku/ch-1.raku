#!/usr/bin/env raku

use v6.*;
my $s = prompt 'Input: $s = ';
my @letters = $s.comb;
print 'Output: ';
@letters
  .kv
  .map: { last $^key if @letters.Bag{$^letter} == 1 } andthen
  .first
  .say;
