sub sum_of_bitwise_and_operator_for_all_unique_pairs ( @a ) {
    return @a.combinations(2).unique.map({ .[0] +& .[1] }).sum;
}


my @tests =
    (1, 2, 3) => 3,
    (2, 3, 4) => 2,
;
use Test;
plan +@tests;
for @tests -> ( :key(@in), :value($expected) ) {
    my $got = sum_of_bitwise_and_operator_for_all_unique_pairs(@in);
    is $got, $expected, "f(@in[]) == $expected";
}
