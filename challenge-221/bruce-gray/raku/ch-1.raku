sub task1 ( @words, $chars --> UInt ) {
    my Bag $b = $chars.lc.comb.Bag;

    return @words.map({ .chars if .lc.comb.Bag ⊆ $b }).sum;
}


my @tests =
    ( <cat bt hat tree>       , 'atach'          ,  6 ),
    ( <hello world challenge> , 'welldonehopper' , 10 ),
;
use Test;
plan +@tests;
for @tests -> ( @in_words, $in_chars, $expected ) {
    is task1( @in_words, $in_chars ), $expected;
}
