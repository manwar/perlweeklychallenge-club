# Best compromise between performance, complexity, reducing chance to "get it wrong",
# and likelihood of a maintenance programmer to reverse-engineer the original requirements.
sub task2 ( Str $s --> Bool ) {
    my BagHash $b = $s.comb.BagHash;
    my @k = $b.keys;

    for @k -> $k {
        $b.remove: $k;
        return True if $b.values.unique.elems == 0|1;
        $b.add:    $k;
    }
    return False;
}
# See ch-2_compare.raku for alternate solutions


constant @tests =
    ( 'abbc'    , 1 ), # Removing one alphabet 'b' will give us 'abc' where each alphabet frequency is the same.
    ( 'xyzyyxz' , 1 ), # Removing 'y' will give us 'xzyyxz'.
    ( 'xzxz'    , 0 ), # Removing any one alphabet would not give us string with same frequency alphabet.

    # True if there is one of each character
    ( 'abcdefg' , 1 ),
    ( 'ab'      , 1 ),
    ( 'a'       , 1 ),

    ( 'aabbccdd' , 0 ),  # False if there is >one of each character; same of all
    ( 'aa'       , 1 ),  # True  if there is >one of each character; 1group
    
    ( 'aaabbbcccc', 1 ),
    ( 'aaabbbcc'  , 0 ),
;
use Test;
plan +@tests;
for @tests -> ($in, $expected) {
    is +task2($in), $expected, "task2($in) == $expected";
}
