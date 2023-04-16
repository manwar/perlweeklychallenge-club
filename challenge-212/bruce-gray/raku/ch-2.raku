sub in_sequential_order ( @ns --> Bool ) {
    return @ns < 2 || so (@ns.skip Z- @ns).all == 1;
}
sub task2 ( UInt $size, @ns --> List ) {
    die unless $size >= 2;
    die unless @ns.all ~~ Real;
    return Nil if @ns.elems !%% $size;

    my @a = @ns.Bag.sort;

    my @r = gather while @a.elems >= $size {
        my @cand = @a.head($size)».key;
        return Nil unless in_sequential_order(@cand);

        take @cand.List;

        @a[$_] = @a[$_].key => (@a[$_].value - 1) for ^$size;
        @a.shift while +@a and @a.head.value == 0;
    }
    return @r.List;
}
# In hindsight, I might have taken a different approach. I like the one-time .sort into an Array of Pairs, but Pairs are immutable, which requires the clumsy reconstruction in line 17, instead of just `.value--`.
#
# Note that the Bag will keep its keys untransformed, while a Hash would have (by default) had Str keys, which would have sorted wrong unless otherwise coerced.
#
# I could have further restricted the type of `ns` in the signatures, but I did not want to complicate the calling test code.


my @tests =
    ( 3, (1,2,3,5,1,2,7,6,3), ( (1,2,3), (1,2,3), (5,6,7) ) ),
    ( 2, (1,2,3            ), -1                            ),
    ( 3, (1,2,4,3,5,3      ), ( (1,2,3), (3,4,5) )          ),
    ( 3, (1,5,2,6,4,7      ), -1                            ),

    # Catch sorting as strings
    ( 2, (9,10,12,13       ), ( (9,10), (12,13) )           ),

    # Also works with Rats.
    ( 3, (1.1,2.1,4.1,3.1,5.1,3.1), ( (1.1,2.1,3.1), (3.1,4.1,5.1) ) ),
;
use Test;
plan +@tests;
for @tests -> ( $in_size, @in_ns, $expected ) {
    my $got = task2( $in_size, @in_ns ) // -1;
    is-deeply $got, $expected;
}
