sub weakest-row(@matrix) {
    # Count the number of 1s in each row and keep track of the row index
    my @row-strength = @matrix.kv.map({ (.grep(* == 1).elems, .key) });

    # Sort based on the number of 1s and then by row index
    @row-strength.sort({$^a[0] <=> $^b[0] || $^a[1] <=> $^b[1]}).map(*[1])
}

# Test the function
say weakest-row([
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 0],
    [1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 1]
]); # Should output (2, 0, 3, 1, 4)

say weakest-row([
    [1, 0, 0, 0],
    [1, 1, 1, 1],
    [1, 0, 0, 0],
    [1, 0, 0, 0]
]); # Should output (0, 2, 3, 1)
