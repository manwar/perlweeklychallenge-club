multi MAIN(*@n where .all ~~ Int) {
    say array-of-product(@n).raku;
}

multi MAIN {
    use Test;
    plan 2;

    my @n = [5, 2, 1, 4, 3];
    cmp-ok array-of-product(@n), &[eqv], [24, 60, 120, 30, 40], "Example 1";

    @n = [2, 1, 4, 3];
    cmp-ok array-of-product(@n), &[eqv], [12, 24, 6, 8],        "Example 2";
}

sub array-of-product(@n) {
    (^@n).map(-> $i { [*] @n[^$i, $i+1..@n.end].flat }).Array;
}
