sub wiggle_sort (@in is copy) {
    for 0..^@in.end -> $i {
        if $i %% 2 {
            @in[$i, $i+1] = @in[$i+1, $i]
                if @in[$i] > @in[$i+1];
        } else {
            @in[$i, $i+1] = @in[$i+1, $i]
                if @in[$i] < @in[$i+1];
        }
    }
    return @in;
}
for <1 5 1 1 6 4>, <1 3 2 2 3 1>,
    <8 12 11 13 9>, <1 2 3 4 5 6 7 8 9> -> @test {
    say (~@test).fmt("%-20s => "), wiggle_sort @test;
}
