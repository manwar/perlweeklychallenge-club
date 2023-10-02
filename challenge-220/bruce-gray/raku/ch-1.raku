sub task1 ( @words --> Seq ) {
    return sort keys [∩] map *.lc.comb.Set, @words;
}


my @tests =
    ( <Perl Rust Raku>  ,  (<r>,)  ),
    ( <love live leave> ,  <e l v> ),
;
use Test;
plan +@tests;
for @tests -> ( @in, @expected ) {
    is-deeply task1(@in), @expected;
}
