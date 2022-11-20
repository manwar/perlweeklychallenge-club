sub is-twice-as-large (@input) {
    my @sorted = reverse sort @input;
    return @sorted[0] >= 2 * @sorted[1];
}
for <1 2 3 4>, <1 2 0 5>, <2 6 3 1>, <4 5 2 3> -> @test {
    say @test, " -> ", is-twice-as-large(@test) ?? 1 !! -1;
}
