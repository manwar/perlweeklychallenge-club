sub task2 ( @strengths ) {

    sub power (@seq) { [*] @seq.minmax.bounds.[0,1,1] }

    return sum map &power, combinations(@strengths, 1..*);
}


constant @tests =
    ( 141, (2, 1, 4) ),
;
use Test; plan +@tests;
for @tests -> ($expected, @in) {
    is task2(@in), $expected;
}
