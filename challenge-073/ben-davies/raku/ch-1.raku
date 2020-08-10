use v6;
unit sub MAIN(+@array where .all ~~ Int:D, Int:D :$s! where 1 <= * <= @array) {
    say (0...@array - $s).map({ @array.skip($_).head($s).min });
}
