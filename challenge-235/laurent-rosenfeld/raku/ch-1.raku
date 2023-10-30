sub can-strictly-increase (@in) {
    my $count = 0;
    for 1..@in.end -> $i {
        $count++ if @in[$i-1] >= @in[$i];
    }
    return $count > 1 ?? False !! True;
}

for <0 2 9 4 6>, <5 1 3 2>, <2 2 3>, <3 3 3> -> @test {
    printf "%-12s => ", "@test[]";
    say can-strictly-increase @test;
}
