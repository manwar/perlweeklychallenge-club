# By storing @a in a Bag, we have all we need to both
# check for an even count of each input number,
# and dish them back out in pairs.
sub task1_bag_unbag ( @a where * %% 2 ) {
    my $b = @a.Bag;
    return $b.values.map(* %% 2).all ?? $b.kxxv.batch(2) !! Empty;
}

# By sorting @a and pairing up neighbors,
# we have exactly the pairs that need to be returned,
# but only after checking that the pairs are all (.[0] == .[1]).
sub task1_check_pairs_equal ( @a where * %% 2 ) {
    my @ret = @a.sort.batch(2);
    return @ret.map({ [eqv] .list }).all ?? @ret !! [];
}

# The two approaches can be combined, yielding a single-expression solution.
sub task1_concise ( @a where * %% 2 ) {
    return @a.Bag.values.all %% 2 ?? @a.sort.batch(2) !! Empty;
}


constant @tests =
    ( (3, 2, 3, 2, 2, 2), [(2, 2), (3, 3), (2, 2)] ),
    ( (1, 2, 3, 4), [] ),

    ( (3, 3, 3, 2, 2, 2), [] ),
;
constant @subs =
    :&task1_bag_unbag,
    :&task1_check_pairs_equal,
    :&task1_concise,
;
use Test; plan @subs * @tests;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( @in, @expected ) {
        is-deeply task1(@in).sort.Array,
                   @expected.sort.Array, "$sub_name: @in[]";
    }
}
