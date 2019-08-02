#!/bin/env perl6

my @usps = <
    al ak az ar ca co ct de fl ga
    hi id il in ia ks ky la me md
    ma mi mn ms mo mt ne nv nh nj
    nm ny nc nd oh ok or pa ri sc
    sd tn tx ut vt va wa wv wi wy
>;

my @words = '/usr/share/dict/words'.IO.lines».lc.grep({ all($_.comb(2)) ∈  @usps }).unique;

my Int $max-length = @words».chars.max;
say "max word length is $max-length";

my @longest-words = @words.grep: { $_.chars == $max-length };
say @longest-words;
