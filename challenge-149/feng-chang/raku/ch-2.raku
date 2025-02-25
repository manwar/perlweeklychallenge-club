#!/bin/env raku

unit sub MAIN(UInt:D \N);

put largest-square(N);

sub largest-square(UInt:D \N --> Str:D) {
    my Str $s = [~] ($_.base(N) for '10'.parse-base(N)^...0);
    ($s.parse-base(N).sqrt.floor ... 1).hyper.grep(-> \n { my \sq = (n²).base(N); sq.comb.unique.elems == sq.chars }).first².base(N)
}

#put "$_\t{largest-square($_)}" for 2..12;
#put "$_\t{largest-square($_)}" for 14..16;
#put "$_\t{largest-square($_)}" for 19;
#put "$_\t{largest-square($_)}" for 24..25;
