sub longest-subseq (@in) {
    my @pairs = @in.combinations: 2;
    my %gaps;
    %gaps{~($_[1] - $_[0])}++ for @pairs;
    # For n gaps, we have n + 1 values
    return %gaps.values.max + 1;
}

for <9 4 7 2 10>, <3 6 9 12>, <20 1 15 3 10 5 8> -> @test {
    printf "%-18s => %d\n", ~(@test), longest-subseq @test;
}
