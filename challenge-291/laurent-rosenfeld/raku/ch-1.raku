sub middle-index (@in) {
    return $_ if @in[0..$_].sum == @in[$_..@in.end].sum
        for 0..@in.end;
    return -1;
}
my @tests = (2, 3, -1, 8, 4), (1, -1, 4), (2, 5);
for @tests -> @test {
    printf "%-12s => ", "@test[]";
    say middle-index @test;
}
