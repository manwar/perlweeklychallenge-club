sub max-prod (@in) {
    my @list = reverse sort { .abs }, @in;
    return [*] @list[0..2] if @list[0..2].all > 0
        or @list[0..2].one > 0;
    if @list[0..2].all < 0 {
        # find first positive value to replace one neg
        my $first = @list[3..@list.end].first({ $_ > 0});
        return [*] (@list[0..1], $first).flat if $first.defined;
    }
    # brute force if we get here
    my @comb-prods = gather {
        for @list.combinations: 3 -> @comb {
            take [*] @comb;
        }
    }
    return @comb-prods.max;
}
for (3, 1, 2), (4, 1, 3, 2), (-1, 0, 1, 3, 1),
    (-8, 2, -9, 0, -4, 3), (-8, 2, 3, 5, 6) -> @test {
    say "@test[]".fmt("%-15s => "), max-prod @test;
}
