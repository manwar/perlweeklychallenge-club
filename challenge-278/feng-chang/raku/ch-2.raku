#!/bin/env raku

unit sub MAIN(Str:D $word is copy, Str:D \c where c.chars == 1);

with $word.index(c) -> \idx {
    $_ = .substr(0, idx+1).comb.sort.join ~ .substr(idx+1) with $word;
}
put $word;
