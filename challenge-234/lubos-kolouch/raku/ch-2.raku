sub unequal-triplets(@ints) {
    # Count the frequency of each number
    my %freq = @ints.Bag;
    
    my $count = 0;
    # Generate all possible combinations of 3 distinct numbers
    for %freq.keys.combinations(3) -> @combo {
        # Calculate the number of triplets possible for each combination
        my $product = 1;
        $product *= %freq{$_} for @combo;
        $count += $product;
    }
    
    return $count;
}

# Test the Raku solution
say unequal-triplets([4, 4, 2, 4, 3]);  # Output: 3
say unequal-triplets([1, 1, 1, 1, 1]);  # Output: 0
say unequal-triplets([4, 7, 1, 10, 7, 4, 1, 1]);  # Output: 28

