#!/usr/bin/env raku
use Test;

is-deeply keyboard-word(< Hello Alaska Dad Peace >), < Alaska Dad    >;
is-deeply keyboard-word(< OMG Bye >),                <               >; 
is-deeply keyboard-word(< BBC CNN OAN >),            < BBC CNN       >;

sub keyboard-word(@a)
{
    @a.grep({ .lc.comb.cache (<=) any < qwertyuiop asdfghjkl zxcvbnm >>>.comb })
}
