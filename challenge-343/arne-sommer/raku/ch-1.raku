#! /usr/bin/env raku

unit sub MAIN (*@nums where @nums.elems > 0 && all(@nums) ~~ Numeric);

say @nums>>.Numeric>>.abs.min;

