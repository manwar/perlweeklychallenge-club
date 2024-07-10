#!/usr/bin/env raku

sub strong-pairs(@arr){
  (@arr.unique.combinations(2).grep: {(abs $_[0] - $_[1]) < $_.min}).elems;
}

say strong-pairs([1,2,3,4,5]);
say strong-pairs([5,7,1,7]);

