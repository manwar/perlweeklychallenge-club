sub task1 ( @bits --> Bool ) {
    constant %h = 0 => 'a', 10 => 'b', 11 => 'c';

    @bits.join ~~ / ^ ( <{ %h.keys }> )+ $ /
        orelse return False;

    my @decoded = %h{ $/[0] };

    return @decoded.tail eq 'a';
}


constant @tests =
    ( (1, 0, 0)    , 1 ),
    ( (1, 1, 1, 0) , 0 ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task1($in).Int, $expected;
}
