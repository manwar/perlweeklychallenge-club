#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0);

say $str.words.sort({ .lc }).join(" ");
