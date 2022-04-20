#!/usr/bin/env raku
use v6;
sub MAIN (Str:D $dictionary) {
   all-sorted-abecedarian-in($dictionary).put;
}

sub all-sorted-abecedarian-in (Str $dictionary) {
   all-abecedarian-in($dictionary).sort({$^a.chars <=> $^b.chars}).Array;
}

sub all-abecedarian-in (Str $dictionary) {
   $dictionary.IO.lines.grep({is-abecedarian($_)}).Array;
}

sub is-abecedarian (Str $word) {
   $word.fc.comb.sort.join('') eq $word.fc;
}

# be chill or annoy forty bossy nosy cops
