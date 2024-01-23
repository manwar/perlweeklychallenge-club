sub weakest-row (@matrix) {
    # Schwartzian transform
    return map { $_[0] },
    sort { $^a[1] <=> $^b[1] || $^a[0] <=> $^b[0]},
    map { [ $_, @matrix[$_].sum ] }, 0..@matrix[0].end;
}

my @tests = (
             [1, 1, 0, 0, 0],
             [1, 1, 1, 1, 0],
             [1, 0, 0, 0, 0],
             [1, 1, 0, 0, 0],
             [1, 1, 1, 1, 1]
            ),
            (
             [1, 0, 0, 0],
             [1, 1, 1, 1],
             [1, 0, 0, 0],
             [1, 0, 0, 0]
            );
for @tests -> @test {
    printf "%-12s ... %-12s  => ", "@test[0]", "@test[*-1]";
    say weakest-row @test;
}
