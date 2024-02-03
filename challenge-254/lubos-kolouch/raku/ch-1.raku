sub is-power-of-three(Int $n --> Bool) {
    # Documentation
    # Determines if the given number is a power of three.
    # Params:
    #   n (Int): A positive integer
    # Returns:
    #   Bool: True if n is a power of three, False otherwise

    return True if $n == 0;
    while $n %% 3 {
        $n div= 3;
    }
    return $n == 1;
}

# Tests
die "Test failed!" unless is-power-of-three(27) == True;
die "Test failed!" unless is-power-of-three(0) == True;
die "Test failed!" unless is-power-of-three(6) == False;
say "All tests passed!";
