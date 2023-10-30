sub find_loops ( @ns --> Seq ) {
    my @n = @ns;

    return gather loop {
        my $start = @n.first( :k, *.defined )
            orelse last;

        my @chain = @n[$start]:delete, { @n[$^prior]:delete } …^ { $^prior.defined.not };

        take @chain if $start == @chain.tail;
    }
}

sub task2 ( @ns --> UInt ) {
    my @loops = find_loops(@ns);

    # say @loops;
    return elems @loops;
}


my @tests =
    ( 3, (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10) ),
    ( 6, (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19) ),
    ( 1, (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17) ),

    ( 3, (1,0,3,2,6,4,5) ),
    ( 1, (1,0) ),
    ( 1, (0,) ),
    ( 1, (0,0) ),
    ( 1, (0,0,0) ),
    ( 4, (0,1,2,3) ),
    ( 0, (99,) ),
;
use Test; plan +@tests;
for @tests -> ( UInt $expected, @in ) {
    is task2( @in), $expected;
}
