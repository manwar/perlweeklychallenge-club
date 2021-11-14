use v6;
unit sub MAIN() {
    .say for pandigits(10).head(5);
}
sub pandigits(Int:D() $base --> Seq:D) {
    (0..^$base).permutations.map(*.reduce: { ($^a + $^b) * $base })
}
