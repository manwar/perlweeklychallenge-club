#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0);

my $elems = $str.comb.grep( * eq any(<a e i o u>) ).elems;

say so $elems && $elems %% 2;
