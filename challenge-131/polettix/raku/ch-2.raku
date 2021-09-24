#!/usr/bin/env raku
use v6;

sub find-pairs ($delimiter-pairs, $search-string) {
   my @delimiters = [], [];
   my @chars = $delimiter-pairs.comb;
   (0, 1).map({@delimiters[$_].push: @chars.shift}) while @chars;
   return @delimiters.map: -> $d {
      $search-string.comb.grep({$^a ~~ $d.any}).join: '';
   };
}

sub MAIN ($delimiter-pairs = '""[]()',
      $search-string = '"I like (parens) and the Apple ][+" they said.') {
   .put for find-pairs($delimiter-pairs, $search-string).List;
}
