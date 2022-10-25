#!/bin/env raku

unit sub MAIN(*@nums);

my Int \k = @nums.pop;
put '@list = (', @nums.join(', '), '), $k = ', k;
put @nums.combinations(2).grep({ .sum %% k }).elems;
