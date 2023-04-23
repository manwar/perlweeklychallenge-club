sub task1 { @^ns.sort: { $_ !%% 2, $_ } }


# This `classify+map(sort)` might be more efficient for very large elements count
# with roughly equal-sized even/odd partitions.
#
# Note that there is no need to expand the classifying expression
# (like `$_ %% 2 ?? 'even' !! 'odd'` or `<odd even>[$_ %% 2]`),
# because .classify is not coercing the keys into Str; Bool works just fine for classifying.
#
# We do have to add `if .so` in the `map`, because the input might have no evens or no odds.
#
sub task1_maybe_more_efficient_I_dont_know_I_did_not_benchmark_it ( @ns ) {
    return @ns.classify(* %% 2).{True, False}.map({ .sort if .so }).flat;
}


my @tests =
    ( (1,2,3,4,5,6) , (2,4,6,1,3,5) ),
    ( (1,2)         , (2,1)         ),
    ( (1,)          , (1,)          ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is-deeply task1($in), $expected;
}
