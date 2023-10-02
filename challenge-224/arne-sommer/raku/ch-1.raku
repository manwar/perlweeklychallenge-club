#! /usr/bin/env raku

unit sub MAIN ($source, $target);

say $target.comb.Bag (<=) $source.comb.Bag
  ?? 'true'
  !! 'false';
