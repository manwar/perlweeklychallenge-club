sub find-loops(@arr) {
    my %visited;
    my $loop-count = 0;

    for 0..^@arr.elems -> $i {
        # Skip if this index has been visited
        next if %visited{$i}:exists;

        # Initialize a new loop
        $loop-count++;
        my $current-index = $i;

        # Find members of this loop
        while !(%visited{$current-index}:exists) {
            %visited{$current-index} = True;
            $current-index = @arr[$current-index];
        }
    }

    return $loop-count;
}

# Test cases
my @test-cases = (
    [[4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10], 3],
    [[0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19], 6],
    [[9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17], 1]
);

for @test-cases.kv -> $i, [$arr, $expected] {
    my $result = find-loops(@$arr);
    say "Test case ", $i + 1, ": ", $result == $expected ?? "Passed" !! "Failed", " (Got: $result, Expected: $expected)";
}

