sub flip-matrix (@input) {
    my @in = @input;
    my @out;
    for @in -> @row {
        my @rev = @row.reverse;
        push @out, map { $_ eq '0' ?? 1 !! 0 }, @rev;
    }
    return @out;
}
for (<1 1 0>, <0 1 1>, <0 0 1>),
    (<1 1 0>, <1 0 1>, <0 0 0>),
    (<1 1 0 0>, <1 0 0 1>, <0 1 1 1>, <1 0 1 0>)
    -> @test {
    say @test, " => ", flip-matrix @test;
}
