sub task1 ( @words --> UInt ) {
    return @words.classify( *.comb.Set )
                 .values
                 .map(      *.combinations(2).elems )
                 .sum;
}


my @tests = map { Hash.new: <expected in> Z=> .list },
    ( 2, <aba aabb abcd bac aabc> ),
    ( 3, <aabb ab ba> ),
    ( 0, <nba cba dba> ),

    (10, <aaa aaa aaa aaa aaa> ),
;
use Test; plan +@tests;
is task1(.<in>), .<expected> for @tests;
