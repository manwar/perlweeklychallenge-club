sub duplicate-zeros(@ints) {
    my $zeros = @ints.grep(0).elems;
    my $i = @ints.elems - 1;
    
    while $zeros > 0 {
        if $i + $zeros < @ints.elems {
            @ints[$i + $zeros] = @ints[$i];
        }
        if @ints[$i] == 0 {
            $zeros--;
            if $i + $zeros < @ints.elems {
                @ints[$i + $zeros] = 0;
            }
        }
        $i--;
    }
    return @ints;
}

# Test cases
say duplicate-zeros([1, 0, 2, 3, 0, 4, 5, 0]);  # Expected: [1, 0, 0, 2, 3, 0, 0, 4]
say duplicate-zeros([1, 2, 3]);  # Expected: [1, 2, 3]
say duplicate-zeros([0, 3, 0, 4, 5]);  # Expected: [0, 0, 3, 0, 0]
