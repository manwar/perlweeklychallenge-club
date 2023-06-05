sub sorted-squares (@in) {
    return sort map {$_²}, @in;
}

for (-2, -1, 0, 3, 4), (5, -4, -1, 3, 6) -> @test {
    say "@test[]".fmt("%-15s => "), sorted-squares @test;
}
