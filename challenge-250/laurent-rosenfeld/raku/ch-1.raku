sub smallest_index (@in) {
    for 0..@in.end -> $i {
        return $i if $i % 10 == @in[$i];
    }
    return -1
}

for (0, 1, 2), (4, 3, 2, 1),
    qw/1 2 3 4 5 6 7 8 9 0/ -> @test {
    printf "%-20s => ", "@test[]";
    say smallest_index @test;
}
