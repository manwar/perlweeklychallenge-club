sub find-third-smallest (@matrix) {
    return (flat map {.flat}, @matrix).sort[2];
}

for ([3, 1, 2], [5, 2, 4], [0, 1, 3]),
    ([2, 1], [4, 5]),
    ([1, 0, 3], [0, 0, 0], [1, 2, 1])
        -> @test {
    say @test, " => ", find-third-smallest(@test);
}
