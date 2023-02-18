sub is-monotonic (@in) {
    [>=] @in or [<=] @in;
}

for <1 2 2 3>, <1 3 2>, <6 5 5 4> -> @test {
    say (~@test).fmt("%-10s => "), + is-monotonic @test;
}
