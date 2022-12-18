sub task2 (@ns) { @ns.grep( * %% 2 ).Bag.max({ .value, -.key }).?key // -1 }


my @tests =
    ( (1,1,2,6,2),  2 ), # Of 2 and 6, 2 appears the most.
    ( (1,3,5,7  ), -1 ), # No even numbers
    ( (6,4,4,6,1),  4 ), # Of 4 and 6, both appear twice, so pick 4 (the smallest).

    ( (2,4,4,6,6),  4 ), # Make sure min of evens does not impact min of max-group
;
use Test;
plan +@tests;
for @tests -> ($in, $expected) {
    is task2($in), $expected, "task2($in) == $expected";
}
