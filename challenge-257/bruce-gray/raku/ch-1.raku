sub task1 ( @ns ) {
    return @ns.map: { [+] @ns X< $_ }; # Concise, but slower. Could also use `»<»` instead of `X<`

    return @ns.sort(+*).antipairs.reverse.Hash.{@ns};
}
sub task1_original_buggy ( @ns ) {
    # My original approach fails on (8, 8, 9).
    my @s = @ns.sort: +*;
    my %w = @s Z=> (-1 X+ [\+] [\<] @s);
    return %w{@ns};
}


use Test; plan +my @tests =
    ( (5, 2, 1, 6) , (2, 1, 0, 3) ),
    ( (1, 2, 0, 3) , (1, 2, 0, 3) ),
    ( (0, 1)       , (0, 1)       ),
    ( (9, 4, 9, 2) , (2, 1, 2, 0) ),

    ( (8, 8, 9)    , (0, 0, 2)    ), # Extra test for low ties. `9,4,9,2` has high ties.
;
for @tests -> ( @in, @expected ) {
    is-deeply task1(@in), @expected;
}
