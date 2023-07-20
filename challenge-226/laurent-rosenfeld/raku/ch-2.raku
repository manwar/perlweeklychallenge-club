sub number-operations (@ints) {
    return @ints.grep({$_ > 0}).unique.elems;
}

for <1 5 0 3 5>, (0,), <2 1 4 0 3> -> @test {
    printf "%-10s => ", "@test[]";
    say number-operations @test;
}
