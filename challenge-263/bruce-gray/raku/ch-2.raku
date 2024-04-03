# Both solutions work with any number of input arrays, not just 2.

sub task2_via_classify ( *@AoA ) {                  # First attempt
    @AoA.pairup
        .classify( *.key, :as{ .value }     )
        .map({     +.key,      .value.sum  })
        .sort;
}

sub task2_via_Bag ( *@AoA ) {                       # Better, IMO
    return @AoA.pairup.Bag.map( *.kv.cache ).sort;
}


constant @tests =
    ( ( (1,1), (2,1), (3,2)        ),  ( (2,2), (1,3) ), ( (1,4), (2,3), (3,2) ) ),
    ( ( (1,2), (2,3), (1,3), (3,2) ),  ( (3,1), (1,3) ), ( (1,8), (2,3), (3,3) ) ),
    ( ( (1,1), (2,2), (3,3)        ),  ( (2,3), (2,4) ), ( (1,1), (2,9), (3,3) ) ),
;
constant @subs =
    :&task2_via_classify,
    :&task2_via_Bag,
;
use Test; plan @tests * @subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( @it1, @it2, @expected ) {
        is-deeply task2(@it1, @it2), @expected, "$sub_name : @it1[]";
    }
}