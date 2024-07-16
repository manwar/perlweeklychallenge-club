sub sort-string ($in) {
    my @positions;
    for $in.words -> $word {
        $word ~~ m/(\D+)(\d+)/;
        @positions[$/[1]] = ~$/[0];

    }
    return "@positions[1..@positions.end]";
}
my @tests = "and2 Raku3 cousins5 Perl1 are4",
            "guest6 Python1 most4 the3 popular5 is2 language7",
            "Challenge3 The1 Weekly2";
for @tests -> $test {
    say $test;
    say sort-string $test;
    say "";
}
