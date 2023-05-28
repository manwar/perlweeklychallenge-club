sub task2 ( @m_original ) {
    my @m = @m_original.map: *.clone.Array;
    sub flip_col ( $c ) { @m[$_][$c] = + ! @m[$_][$c] for    @m.keys }
    sub flip_row ( $r ) { @m[$r][$_] = + ! @m[$r][$_] for @m[0].keys }

    sub score ( ) {
        return @m.map( *.join.parse-base(2) ).sum;
    }

    my $half = @m.elems / 2;

    for @m.keys         -> $r { flip_row($r) if @m[$r][0]    == 0     }
    for @m[0].keys.skip -> $c { flip_col($c) if @m».[$c].sum <  $half }

    return score();
}


my @tests =
    ( 39, ( (0,0,1,1), (1,0,1,0), (1,1,0,0) ) ),
    (  1, ( (0,),                           ) ),
    (  1, ( (1,),                           ) ),
;
use Test;
plan +@tests;
for @tests -> ( $expected, @in ) {
    is task2(@in), $expected;
}
