#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0, $char where $char.chars == 1);

say ( (100 * $str.comb.Bag{$char} / $str.chars) + 0.5).int;
