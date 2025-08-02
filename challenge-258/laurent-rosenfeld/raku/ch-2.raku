sub sum-of-values ($k, @in) {
    my @eligibles = map { @in[$_] },
        grep {$_.base(2).comb.sum == $k}, 0..@in.end;
    return @eligibles.sum;
}

my @tests = (1, <2 5 9 11 3>),
            (2, <2 5 9 11 3>),
            (0, <2 5 9 11 3>);

for @tests -> @test {
    printf "%-15s => ", "@test[]";
    say sum-of-values @test[0], @test[1];
}
