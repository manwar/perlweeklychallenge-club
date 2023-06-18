sub is-arithmetic ( @ns --> Bool ) {
    @ns.rotor(2 => -1).map({ [-] .list }).Set == 1;
}

# Concise but inefficient; about O(2ⁿ)
sub task2 (@ns --> UInt) {
    return @ns.combinations( 2 .. @ns.elems )
              .reverse
              .first(&is-arithmetic)
              .elems;
}

# Would pass the three tests in the task, by cheating:
# sub task2(@ns){ 1 + @ns.combinations(2).map({[-] .list}).Bag.values.max }


my @tests =
    ( (  9, 4,  7,  2, 10        ), 3 ),
    ( (  3, 6,  9, 12            ), 4 ),
    ( ( 20, 1, 15,  3, 10, 5, 8  ), 4 ),

    ( ( 1, 2, 3, 5, 6, 7         ), 4 ), # Break the cheating; Best is (1,3,5,7)
    ( ( 1, 1, 2, 3, 5, 8, 13, 21 ), 3 ), # Fibonacci
    ( ( 1, 2, 4, 8, 16, 32       ), 2 ), # Geometric
;
use Test;
plan +@tests;
for @tests -> ( @in, $expected ) {
    is task2( @in ), $expected;
}
