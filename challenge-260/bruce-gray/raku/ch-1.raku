my &task1 = *.Bag.values.repeated.not;


use Test; plan +constant @tests =
    ( 1, (1,2,2,1,1,3) ),
    ( 0, (1,2,3) ),
    ( 1, (-2,0,1,-2,1,1,0,1,-2,9) ),
;
for @tests -> ( $expected, @in ) {
    is +task1(@in), $expected, "@in[]";
}
