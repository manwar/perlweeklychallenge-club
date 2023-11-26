# Function to get the prime factors of a number
sub prime-factors(Int $n is copy) {
    my @factors;
    while $n %% 2 {
        @factors.push: 2;
        $n div= 2;
    }
    for 3, 5 ... * -> $i {
        last if $i > sqrt($n);
        while $n %% $i {
            @factors.push: $i;
            $n div= $i;
        }
    }
    @factors.push: $n if $n > 2;
    return @factors;
}

# Function to sort numbers by the count of their prime factors
sub sort-by-prime-factors(@nums) {
    my @sorted-nums = @nums.sort: { prime-factors($_).elems, $_ };
    return @sorted-nums;
}

# Test Cases
say sort-by-prime-factors([11, 8, 27, 4]); # Output: [11, 4, 8, 27]
