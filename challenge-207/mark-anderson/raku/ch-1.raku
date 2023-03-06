#!/usr/bin/env raku
use Test;

is keyboard-word(< Hello Alaska Dad Peace >), < Alaska Dad    >;
is keyboard-word(< OMG Bye >),                <               >; 
is keyboard-word(< BBC CNN OAN >),            < BBC CNN       >;

sub keyboard-word(@a)
{
    @a.grep({ .lc.comb.cache (<=) any < qwertyuiop asdfghjkl zxcvbnm >>>.comb })
}
