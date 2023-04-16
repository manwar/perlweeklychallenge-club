sub rearrange (@in, $size) {
    my @result;
    return -1 unless @in.elems %% $size;
    my $bag  = @in.Bag;
    while ($bag) {
        my $min = $bag.min.key;
        my @list = $min..^($min + $size);
        return -1 unless @list ⊆ $bag;
        push @result, @list;
        $bag = $bag (-) @list;  # set difference
    }
    return @result;
}

for ((1,2,3,5,1,2,7,6,3), 3), ((1,2,3), 2), ((1,2,3), 3),
    ((1,2,4,3,5,3), 3), ((1,5,2,6,4,7), 3),
    ((1,5,2,6,4,7), 2) -> @test {
    say @test;
    say rearrange(|@test), "\n";
}
