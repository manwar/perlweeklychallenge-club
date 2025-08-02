sub task1_combinations_bit-twiddling ( @ns --> Bool ) {
    return so @ns.grep(* != 0).combinations(2).map({ [+|] .list }).any +& 1 == 0;
}

# The task can be reduced to: are there at least two even numbers.
sub task1_reduced_count { @^ns.grep( * %% 2 ) >= 2 }         # Concise
sub task1_reduced_head  { @^ns.grep( * %% 2 ).head(2) == 2 } # Conceptually faster.


constant @subs =
    :&task1_combinations_bit-twiddling,
    :&task1_reduced_count,
    :&task1_reduced_head,
;
constant @tests =
    ( True  , ( 1, 2, 3,  4, 5 ) ),
    ( True  , ( 2, 3, 8, 16    ) ),
    ( False , ( 1, 2, 5,  7, 9 ) ),

    # ( False , ( 0, 0 ) ), # On 2nd read, this is disallowed by the task description.
;
use Test; plan +@subs * +@tests;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $expected, @in ) {
        is task1(@in), $expected, "$sub_name : @in[]";
    }
}