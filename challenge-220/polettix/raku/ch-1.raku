#!/usr/bin/env raku
use v6;
sub MAIN (*@words) { say common-characters(@words) }

sub common-characters (@words) {
   return [] unless @words;
   @words
      .map({ .lc.comb })
      .reduce(-> $a, $b { my $s = $b.Set; $a.grep({ $_ ∈ $s }) })
      .sort;
}
