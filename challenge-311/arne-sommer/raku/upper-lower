#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[a..z A..Z]>+/);

say $str.comb.map({ /<[a..z]>/ ?? .uc !! .lc }).join;
