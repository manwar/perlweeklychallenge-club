sub find_slices (@in) {
    my @out;
    return @out if @in.elems < 3;
    for 0..@in.end - 2 -> $i {
        my $gap = @in[$i+1] - @in[$i];
        for $i+2..@in.end -> $j {
            last if @in[$j] - @in[$j-1] != $gap;
            push @out, @in[$i..$j];
        }
    }
    return @out;
}
for <1 2 3 4>, <2 5>, <3 5 7 9>, <2 5 9> -> @test {
    say (~@test).fmt("%-10s => "), find_slices @test;
}
