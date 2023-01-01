sub move-zero (@in) {
    return (@in.grep({$_ != 0}), @in.grep({$_ == 0})).flat;
}
for <1 0 3 0 0 5>, <1 6 4>, <0 1 0 2 0> -> @test {
    say (~@test).fmt("%-15s"), " => ", move-zero @test;
}
