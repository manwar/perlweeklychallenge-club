use v6;
unit sub MAIN(IO(Str:D) $file, Int:D $a, Int:D $b) {
    .say for $file.slurp.lines.pairs.grep($a <= *.key + 1 <= $b).map(*.value);
}
