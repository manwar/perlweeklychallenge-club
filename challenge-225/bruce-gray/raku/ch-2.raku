sub abs_diff      {      abs $^x - $^y     }
sub partial_sum_0 { 0, |[\+] @^a.head(*-1) }

sub task2 ( Int @ns --> Array ) {

    my @left  = partial_sum_0(@ns);
    my @right = partial_sum_0(@ns.reverse).reverse;

    return @left »[&abs_diff]« @right;
}


my @tests =
    ( (10, 4, 8, 3)   , (15, 1, 11, 22)    ),
    ( (1,)            , (0,)               ),
    ( (1, 2, 3, 4, 5) , (14, 11, 6, 1, 10) ),
;
use Test;
plan +@tests;
for @tests -> ( @in, @expected ) {
    is-deeply task2( Array[Int].new(@in) ), @expected.Array;
}
