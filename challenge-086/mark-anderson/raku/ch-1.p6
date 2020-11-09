multi MAIN ($A where * ~~ Int, *@N where .all ~~ Int) {
    say pair-diff($A, @N);
}

multi MAIN {
    use Test;
    plan 3;

    ok  pair-diff(7,  [10, 8, 12, 15, 5]),   "example 1";
    ok  pair-diff(6,  [1, 5, 2, 9, 7]),      "example 2";
    nok pair-diff(15, [10, 30, 20, 50, 40]), "example 3";
}

sub pair-diff($A, @N) {
    @N.sort
      .combinations(2)
      .first({ $_[1] - $_[0] == $A })
      .Bool
      .UInt
}
