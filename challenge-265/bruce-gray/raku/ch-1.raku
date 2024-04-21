sub task1 ( @ns --> UInt:_ ) {
    my $limit = +@ns * 0.33;

    return @ns.Bag.grep( *.value >= $limit ).min.?key;
}
# Credit: After reading wambash's code, I changed from `or return Nil`
# to in-line the `.min.?key` using the `.?` trick, which I had not
# known worked on the -Inf that `.min` returns on an empty list.
# I also learned a `.nodemap` trick that, while I did not use it here,
# I know I will have use for in the future:
#   https://docs.raku.org/routine/nodemap
#       When applied to Associatives, it will act on the values


use Test; plan +constant @tests =
    (   3, (1,2,3,3,3,3,4,2) ),
    (   1, (1,1) ),
    (   1, (1,2,3) ),

    ( Nil, (1,2,3,4,5) ),
    ( Nil, (1,1,2,2,3,4,5) ),
    (   2, (1  ,2,2,3,4,5) ),
;
for @tests -> ( $expected, @in ) {
    is task1(@in), $expected;
}
