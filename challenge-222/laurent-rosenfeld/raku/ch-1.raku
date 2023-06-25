sub matching-members (@in) {
    my @sorted = @in.sort;
    my $match = 0;
    $match++ if @in[$_] == @sorted[$_] for 0..@in.end;
    return $match;
}

for <1 1 4 2 1 3>, <5 1 2 3 4>, <1 2 3 4 5> -> @test {
    printf "%-12s => ", "@test[]";
    say matching-members @test;
}
