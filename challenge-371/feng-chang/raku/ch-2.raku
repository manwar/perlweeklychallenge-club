#!/bin/env raku

unit sub MAIN(*@nums);

@nums = +«@nums;
put (^+@nums).combinations(2..+@nums-1).grep({ .sum + @$_ == @nums[@$_].sum }).map({ @nums[@$_] }).gist;
