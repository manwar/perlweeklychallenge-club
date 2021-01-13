#
# from a hint at https://www.geeksforgeeks.org/find-a-pair-with-the-given-difference/
#

multi MAIN(Int $A, *@N where .all ~~ Int) {
    say pair-diff(+$A, @N.map(+*));
}

multi MAIN {
    use Test;
    plan 3;

    ok  pair-diff(7,  [10, 8, 12, 15, 5]),   "Example 1";
    ok  pair-diff(6,  [1, 5, 2, 9, 7]),      "Example 2";
    nok pair-diff(15, [10, 30, 20, 50, 40]), "Example 3";
}

sub pair-diff($A, @N) {
    my $b = bag @N;

    if $A == 0 {
        return +$b.values.first(* > 1).so;
    }

    for $b.keys -> $k {
        return 1 if $b{$A+$k};
    }

    return 0;
}
