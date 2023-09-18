sub task1 (@words) {
    return @words.map( *.comb.Bag )
                 .reduce( &[∩] )
                 .kxxv
                 .sort;
}


my @tests =
    ( <java javascript julia> , <j a>.sort ), # Sort needed to match task example.
    ( <bella label roller>    , <e l l> ),
    ( <cool lock cook>        , <c o>   ),
;
use Test; plan +@tests;
for @tests -> ( @in, @expected ) {
    is-deeply task1(@in), @expected;
}
