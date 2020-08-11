#! /usr/bin/env raku

my %result = $*ARGFILES.comb>>.lc.grep(* ~~ /<:L>/).Bag;

for %result.keys.sort -> $key
{
  say "$key: %result{$key}";
}

