sub task1 { @^ns».comb.flat».Numeric }


constant @tests = map { Hash.new: <in expected> Z=> .list },
    ( (1, 34,  5,  6), (1, 3, 4, 5, 6)       ),
    ( (1, 24, 51, 60), (1, 2, 4, 5, 1, 6, 0) ),
;
use Test;
plan +@tests;
is-deeply task1(.<in>), .<expected> for @tests;
