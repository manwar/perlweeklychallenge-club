sub strong-pairs (@in) {
    my` $count = 0;
    for @in.unique.combinations: 2 -> @pair {
        $count++ if 0 < (@pair[0] - @pair[1]).abs < @pair.min;
    }
    return $count;
}

my @tests = (1, 2, 3, 4, 5), (5, 7, 1, 7);
for @tests -> @test {
    printf "%-10s => ", "@test[]";
    say strong-pairs @test;
}
