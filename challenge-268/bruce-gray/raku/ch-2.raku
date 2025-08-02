constant &task2_also_works_with_odd = *.sort(+*).batch(2)».reverse.flat;

sub task2_does_not_need_flat ( @ns where +@ns %% 2 ) {
    return @ns.sort(+*).map: { |($^y, $^x) };
}


constant @tests =
    ( ( 2, 5, 3, 4             ) , (3, 2, 5, 4) ),
    ( ( 9, 4, 1, 3, 6, 4, 6, 1 ) , (1, 1, 4, 3, 6, 4, 9, 6) ),
    ( ( 1, 2, 2, 3             ) , (2, 1, 3, 2) ),
;
constant @subs =
    :&task2_also_works_with_odd,
    :&task2_does_not_need_flat,
;
use Test; plan +@subs * +@tests;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( @in, @expected ) {
        is-deeply task2(@in), @expected, "$sub_name : @in[]";
    }
}
