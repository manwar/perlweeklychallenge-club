for (2, <4 5 1 6>), (2, <1 2 3 4>),
    (3, <1 3 4 5>), (4, <5 1 2 3>),
    (4, <7 2 4 5>), (2, < 1 2 3 4 5 6 7 >)
        -> ($k, @test) {
    my $count = 0;
    for (0..@test.end).combinations(2) -> @comb {
        $count++ if (@test[@comb[0]] + @test[@comb[1]]) %% $k;
    }
    say "$k  (@test[])  -> ", $count;
}
