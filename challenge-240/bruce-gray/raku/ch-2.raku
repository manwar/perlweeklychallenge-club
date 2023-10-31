sub task2 ( Int @ns --> List ) {

    # if @ns.grep( * !~~ 0..@ns.end ) -> @bad {
    #     warn "These values are outside the range of possible keys, and so will be undefined: @bad[]";
    # }

    return @ns[ @ns ];
}


constant @tests =
    ( (0, 2, 1, 5, 3, 4), (0, 1, 2, 4, 5, 3) ),
    ( (5, 0, 1, 2, 3, 4), (4, 5, 0, 1, 2, 3) ),

    # ( (5, 0, 1, 2, 3, 9), (9, 5, 0, 1, 2, Int) ), # Should warn. No time this week to implement testing of warnings.
;
use Test; plan +@tests;
for @tests -> ( @in, @expected ) {
    is-deeply task2(Array[Int].new(@in)), @expected;
}
