sub pairings (@in) {
    my @sorted = @in.sort.reverse;
    return @sorted[1] + @sorted[3];
}
for <1 2 3 4>, <6 5 4 3 2 1>, <0 2 1 3> -> @test {
    say "@test[]".fmt("%-15s => "), pairings @test;
}
