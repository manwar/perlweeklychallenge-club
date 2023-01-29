sub find-missing (@in) {
    return ~(|(0..@in.elems) (-) @in).keys.sort;
}
for (0, 1, 3), (0, 1), (0, 1, 3, 5, 7, 2) -> @test {
    say  (~@test).fmt("%-15s => "), find-missing @test;
}
