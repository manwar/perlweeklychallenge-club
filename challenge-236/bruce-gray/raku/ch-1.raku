sub make_change ( BagHash $bankroll is rw, $change_owed is copy --> Bool ) {

    for $bankroll.keys.sort.reverse -> $bill {

        while $bankroll{$bill} and $change_owed >= $bill {
            $bankroll{$bill} -= 1;
            $change_owed     -= $bill;
        }
    }

    return $change_owed == 0;
}

sub task1 ( @ns --> Bool ) {
    constant $juice_cost = 5;

    my BagHash $carny_roll;
    for @ns -> $bill {
        $carny_roll{$bill}++;
        make_change( $carny_roll, $bill - $juice_cost )
             or return False;
    }
    return True;
}


my @tests =
    ( True  , ( 5, 5,  5, 10, 20 ) ),
    ( False , ( 5, 5, 10, 10, 20 ) ),
    ( True  , ( 5, 5,  5, 20     ) ),
;
use Test; plan +@tests;
for @tests -> ( Bool $expected, @in ) {
    is task1(@in), $expected;
}
