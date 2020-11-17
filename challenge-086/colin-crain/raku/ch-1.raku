#!/usr/bin/env perl6
#
#
#       difference-engine.raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $target = 100, *@input) ;

@input.elems == 0 and @input = 100, 25, 15, 0 , -1, -2, -100;

say @input  .sort
            .combinations(2)
            .map({$_[1]-$_[0]})
            .grep({$_ == $target.abs})
            .elems  ?? 1
                    !! 0;
