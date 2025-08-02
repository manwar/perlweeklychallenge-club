sub unique-sum-zero(Int $n --> Array) {
    # Generate an array of `n` unique integers that sum to zero.

    my @result = flat (1 ..^ ($n div 2 + 1)), (-1 ...^ -($n div 2 + 1));
    @result.push(0) if $n % 2 != 0;
    return @result;
}

# Tests
say "Test 1 (5): ", unique-sum-zero(5);
die "Test 1 failed" unless unique-sum-zero(5).sum == 0;

say "Test 2 (3): ", unique-sum-zero(3);
die "Test 2 failed" unless unique-sum-zero(3).sum == 0;

say "Test 3 (1): ", unique-sum-zero(1);
die "Test 3 failed" unless unique-sum-zero(1).sum == 0;
