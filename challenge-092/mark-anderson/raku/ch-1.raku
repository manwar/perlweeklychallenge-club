#!/usr/bin/env raku

# Note: this program runs fine on rakudo 2020.05 but fails on 2020.01

multi MAIN($A, $B) {
    say is-isomorphic($A, $B);
}

multi MAIN {
    use Test;
    plan 3;

    ok  is-isomorphic("abc", "xyz"), "Example 1";
    ok  is-isomorphic("abb", "xyy"), "Example 2";
    nok is-isomorphic("sum", "add"), "Example 3";
}

sub is-isomorphic($A, $B) {
    my $h = Hash.new;
    my $s = SetHash.new;

    for $A.comb Z $B.comb -> ($a, $b) {
        if $h{$a} {
            return 0 unless $h{$a} eq $b;
        }

        else {
            return 0 if $s{$b};
            $h{$a} = $b;
            $s.set($b);
        }
    }

    return 1;
}
