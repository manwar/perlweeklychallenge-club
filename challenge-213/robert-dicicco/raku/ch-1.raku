#!/usr/bin/env raku
#`{
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-17
Challenge 213 Fun Sort ( Raku )
-----------------------------------
}
use v6;

multi MAIN (*@list where @list.elems >= 1
              && @list.all ~~ Int)
{
    my @res;
    my @sorted = @list>>.Int.sort;
    my @evens = grep {$_ %% 2}, @sorted;
    my @odds = grep {$_ % 2}, @sorted;

    for (^@evens.elems) -> $x {
        @res.push: @evens[$x];
    }

    for (^@odds.elems) -> $x {
        @res.push: @odds[$x];
    }

    print "(", join ', ', flat(@res);
    print ")";
}

multi MAIN (*@slurp)
{
  say '-1';
}

#`{
-----------------------------------
SAMPLE OUTPUT
raku FunSort.rk 1 2 3 4 5 6
(2, 4, 6, 1, 3, 5)

raku FunSort.rk 1 2
(2, 1)

raku FunSort.rk 1
(1)
-----------------------------------
}
