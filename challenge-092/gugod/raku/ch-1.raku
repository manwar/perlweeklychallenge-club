
sub MAIN {
    tests;
}

sub isomorphic (Str $a, Str $b) {
    return [eqv] ($a, $b).map(
        -> $s {
            $s.comb.keys.tail(*-1).map(
                -> $i { $s.substr($i, 1) eq $s.substr($i-1, 1) }
            )
        }
    );
}

sub tests {
    my @cases := (
        (True, "abc", "xyz"),
        (True, "abb", "xyy"),
        (True, "look", "moon"),

        (False, "sum", "add"),
        (False, "sun", "moon"),
        (False, "Moose", "Mouse"),
    );

    for @cases -> ($expected, $a, $b) {
        if $expected eqv isomorphic($a, $b) {
            say "ok - $a vs $b";
        } else {
            say "not ok - $a vs $b"
        }
    }
}
