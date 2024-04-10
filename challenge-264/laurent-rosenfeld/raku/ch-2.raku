sub target-array (@source, @indices) {
    my @target;
    for 0..@source.end -> $i {
        splice @target, @indices[$i], 0,  @source[$i];
    }
    return @target;
}

my @tests = ( (0, 1, 2, 3, 4), (0, 1, 2, 2, 1) ),
            ( (1, 2, 3, 4, 0), (0, 1, 2, 3, 0) ),
            ( (1,), (0,) );
for @tests -> @test {
    printf "%-10s - %-10s => ", "@test[0]", "@test[1]";
    say target-array @test[0], @test[1];
}
