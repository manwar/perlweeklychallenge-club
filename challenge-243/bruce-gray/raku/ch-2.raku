# Note that `div` can take the place of `floor after division`
# only because the task specifies integers.
#   https://docs.raku.org/language/operators#infix_div
#   https://docs.raku.org/language/operators#infix_X
#   https://docs.raku.org/language/operators#Cross_metaoperators
sub task2_simple ( @ns ) {
    return sum( @ns Xdiv @ns );
}

constant &task2_inscrutable = { [+] [Xdiv] @^ns xx 2 };

# For 10_000 element array (100 duplicates of a line of 100 random 2-digit numbers):
#   3 seconds for task2_faster, vs 42 seconds for &task2_simple.
sub task2_faster ( @ns ) {
    my @p = @ns.Bag;

    return sum map { [*] |$_».value, |[div] $_».key }, ( @p X @p );
}



constant @subs  = :&task2_simple, :&task2_inscrutable, :&task2_faster;
constant @tests =
    ( 10, (2, 5, 9) ),
    ( 49, (7, 7, 7, 7, 7, 7, 7) ),
;
use Test; plan +@subs * +@tests;
for @subs -> ( :key($sub_name), :value($task2) ) {
    for @tests.kv -> $i, ($expected, @ns) {
        is $task2.(@ns), $expected, "$sub_name.fmt('%-18s'): Example {$i+1}";
    }
}
