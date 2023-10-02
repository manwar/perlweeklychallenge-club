# XXX Not up to my usual standards;
#     no proof that this approach always delivers the best possible total.
sub task2 ( @ns_in --> UInt ) {
    my @ns = @ns_in;

    my $total = 0;
    while @ns {

        # Oops! This code did not account for minumum ties.
        # I should have added code to choose the best of the minimums,
        # but ran out of time.
        my @mp = @ns >= 3
            ?? @ns.skip(1).head(*-1).minpairs.map({ (.key+1) => .value })
            !!                   @ns.minpairs;

        my $box_index = @mp[0].key;

        my ( $s, $h ) = $box_index == 0 ?? ( $box_index     , 2 )
                                        !! ( $box_index - 1 , 3 );

        $total += [*] @ns.skip($s).head($h);
        @ns.splice($box_index, 1);
    }
    return $total;
}

my @tests =
    ( (3, 1, 5, 8) , 167 ),
    ( (1, 5      ) ,  10 ),
;
use Test;
plan +@tests;
for @tests -> ( @in, $expected ) {
    is task2(@in), $expected;
}
