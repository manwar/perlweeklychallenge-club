#! /usr/bin/env raku

unit sub MAIN (*@R where @R.elems > 0 && all(@R) > 0);

say + so 1 < any(@R.combinations(3)>>.sum) < 2;
