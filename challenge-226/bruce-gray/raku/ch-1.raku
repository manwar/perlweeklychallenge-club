sub task1 ( Str $s, Int @is --> Str ) {
    die "Bad @is: @is[]" unless @is.Bag eqv (^$s.chars).Bag;

    # Essentially a super-efficient Radix sort:
    my @r;
    @r[ @is ] = $s.comb;
    return @r.join;

    # Alternatively, single expression:
    # return (@is Z $s.comb).sort».[1].join;

    # My first attempt at a solution,
    # affected by having to leave out Radix
    # from my TPRC talk on Sorting:
    # my @c = $s.comb;
    # return @c[ @c.keys.sort({ @is[$_] }) ].join;
}


my @tests =
    ( 'challenge' , 'lacelengh' , (3,2,0,5,4,8,6,7,1) ),
    ( 'perlraku'  , 'rulepark'  , (4,7,3,1,0,5,2,6)   ),
;
use Test;
plan +@tests;
for @tests -> ( $expected, $in_str, @in_dexes ) {
    is task1($in_str, Array[UInt].new(@in_dexes)), $expected;
}
