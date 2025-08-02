constant &task2a = { @^ns.Bag.max(:v).sum } # Only on Rakudo 2023.08 and higher

constant &task2b = { @^ns.Bag.maxpairs».value.sum }

constant &task2c = { .elems * .[0].value given @^ns.Bag.maxpairs }

constant &task2d = { (my %c).push: @^ns.Bag.invert; .key * +.value given %c.max }

constant &task2e = { .key * +.value given @^ns.Bag.classify({.value}, :as{.key}).max }


constant @tests =
    ( 4, (1, 2, 2, 4, 1, 5) ),
    ( 5, (1, 2, 3, 4, 5) ),
;
constant @subs =
    :&task2a,
    :&task2b,
    :&task2c,
    :&task2d,
    :&task2e,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( $expected, @in ) {
        is task2(@in), $expected, "$sub_name : @in[]";
    }
}
