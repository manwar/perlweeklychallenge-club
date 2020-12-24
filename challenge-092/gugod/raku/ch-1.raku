
sub MAIN {
    tests;
}

sub isomorphic (Str $A, Str $B) {
    my %trans;
    return False unless $A.chars == $B.chars;

    for $A.comb Z $B.comb -> ($a, $b) {
        if %trans{"ab"}{$a}:exists and %trans{"ab"}{$a} ne $b {
            return False
        }
        %trans{"ab"}{$a} = $b;

        if %trans{"ba"}{$b}:exists and %trans{"ba"}{$b} ne $a {
            return False
        }
        %trans{"ba"}{$b} = $a;
    }
    return True;
}

sub tests {
    my @cases := (
        (True, "abc", "xyz"),
        (True, "abb", "xyy"),
        (True, "look", "moon"),
        (True, "sum", "abc"),

        (False, "where", "how"),
        (False, "this", "that"),
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
