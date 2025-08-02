sub sum-of-values-with-k-ones(@arr, Int $k) {
    my $sum = 0;
    for 0..@arr.elems - 1 -> $index {
        $sum += @arr[$index] if $index.base(2).comb('1').elems == $k;
    }
    return $sum;
}

# Testing the function with the provided examples
my @ints = 2, 5, 9, 11, 3;
say sum-of-values-with-k-ones(@ints, 1); # Output: 17
say sum-of-values-with-k-ones(@ints, 2); # Output: 11
say sum-of-values-with-k-ones(@ints, 0); # Output: 2
