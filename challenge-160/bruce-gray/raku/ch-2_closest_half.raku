# Returns a list of all items that have the minimum value as calculated by &f,
# instead of the single item that .min() would return.
sub min_list ( @a, &f ) {
    my $min = @a.min(&f).&f;
    return @a.grep: *.&f == $min;
}

# Generalized solution, finding the balance (or near-balance) points,
# checking *at* each item and *in-between* item pairs.
# Returns:  [0] the lowest imbalance (zero if perfectly balanced), and
#           [1] the items with that lowest imbalance.
sub eq_index_closest_half ( @list --> List ) {
    my ($left, $right) = 0, @list.sum;

    my @index_diffs = gather for @list.kv -> $k,$v {
        $right -= $v; take ( $k     , abs($left - $right) );
        $left  += $v; take ( $k + ½ , abs($left - $right) );
    }
    pop @index_diffs;

    my @r = @index_diffs.&min_list( *.[1] );

    return @r.head.[1], @r».[0];
}

# TWC task is now just eq_index_closest_half, removing half-indexes and non-zero imbalances.
sub eq_index ( @list --> Array ) {
    my ($lowest_difference, $indexes) = eq_index_closest_half(@list);
    return [$lowest_difference > 0 ?? () !! $indexes.grep( * ~~ Int )];
}

# Tests from ch-2.raku, adding the expected best imbalance,
# and the indexes with half-points for eq_index_closest_half() *if* different from eq_index().
my @tests =
    ( 1, 3, 5, 7, 9       ) => (( 3,                  ), 0,            ),
    ( 1, 2, 3, 4, 5       ) => ((                     ), 1, (3,       )),
    ( 2, 4, 2,            ) => (( 1,                  ), 0,            ),
    (-7, 1, 5, 2,-4, 3, 0 ) => (( 3, 6,               ), 0, (3, 5.5, 6)),
    ( 2, 4, 6,            ) => ((                     ), 0, (1.5,     )),
    ( 2, 9, 2,            ) => (( 1,                  ), 0,            ),
    ( 1,-1, 1,-1, 1,-1, 1 ) => (( 0, 1, 2, 3, 4, 5, 6,), 0,            ),
;
use Test;
plan 3 * @tests;
for @tests -> ( :key(@in), :value(@exp) ) {
    my ($expected1, $, $) = @exp;
    my @got = eq_index(@in);
    is @got, $expected1, "eq_index(@in[]) == $expected1[]";
}
for @tests -> ( :key(@in), :value(@exp) ) {
    my ($expected1, $expected_best2, $expected_indexes2) = @exp;
    $expected_indexes2 //= $expected1 if $expected_best2 == 0;
    my ($got_best, $got_indexes) = eq_index_closest_half(@in);
    is $got_best,    $expected_best2,    "eq_index_closest_half(@in[]) has best    $expected_best2";
    is $got_indexes, $expected_indexes2, "eq_index_closest_half(@in[]) has indexes $expected_indexes2[]";
}
