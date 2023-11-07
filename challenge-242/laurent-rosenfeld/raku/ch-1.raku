sub diff (@a, @b) {
    return map {.keys}, @a (-) @b, @b (-) @a;
}

for (<1 2 3>, < 2 4 6>), (<1 2 3 3>, <1 1 2 2>) -> @test {
    printf "%-8s - %-8s => ", "@test[0]", "@test[1]";
    say diff @test[0], @test[1];
}
