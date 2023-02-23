sub third-largest (@in) {
    my @s = @in.sort.reverse;
    return @s.elems >= 3 ?? @s[2] !! @s[0];
}
for <5 3 4>, <5 6>, <5 4 4 3>, <5 6 7 8 2 1> -> @test {
    say (~@test).fmt("%-12s => "), third-largest @test;
}
