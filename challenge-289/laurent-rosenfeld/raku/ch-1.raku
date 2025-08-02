sub third-max (@in) {
    my @sorted = @in.unique.sort.reverse;
    return @sorted[2]:exists ?? @sorted[2] !! @sorted[0];
}

my @tests = (5, 6, 4, 1), (4, 5), (1, 2, 2, 3);
for @tests -> @test {
    printf "%-10s => ", "@test[]";
    say third-max @test;
}
