sub max-gap (@in) {
    return 0 if @in.elems < 2;
    my @sorted = sort @in;
    my %gaps;
    for 1..@sorted.end -> $i {
        push %gaps, ( @sorted[$i] - @sorted[$i-1] => $i );
    }
    my $max-gap = %gaps.keys.max;
    return %gaps{$max-gap}.elems;
}
for <2 5 8 1>, <2 7>, (3,), <12 2 6 5 15 9> -> @test {
    say (~@test).fmt("%-20s => "), max-gap @test;
}
