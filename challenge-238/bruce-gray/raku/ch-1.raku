my &task1 = *.produce: &[+];                    # "Refined" solution

# sub task1 ( @ns --> Seq ) { return [\+] @ns } # Original solution


my @tests =
    ( (1, 2, 3, 4, 5) , (1, 3, 6, 10, 15) ),
    ( (1, 1, 1, 1, 1) , (1, 2, 3, 4, 5) ),
    ( (0, -1, 1, 2)   , (0, -1, 0, 2) ),
;
use Test; plan +@tests;
for @tests -> ( @in, @expected ) {
    is-deeply task1(@in), @expected;
}
