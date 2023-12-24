sub task2_semicolon ( @m ) {
    return @m.keys.skip.map: -> \r {
        @m[0].keys.skip.map: -> \c {
            @m[r-1,r ; c-1,c].sum
        }
    }
}
sub task2_stream ( @m ) {
    return @m.map( *.rotor(2 => -1)».sum )
             .rotor(2 => -1)
             .map: { [»+«] .list };
}


my @tests =
    ( ((1,2,3,4),(5,6,7,8),(9,10,11,12))        , ((14,18,22),(30,34,38))   ),
    ( ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)) , ((2,1,0),(1,2,1),(0,1,2)) ),
;
my @subs = :&task2_semicolon, :&task2_stream;
use Test; plan @tests * @subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( @in, @expected ) {
        my @got = task2(@in);
        is-deeply @got».List, @expected, "$sub_name - @in[0]";
    }
}
