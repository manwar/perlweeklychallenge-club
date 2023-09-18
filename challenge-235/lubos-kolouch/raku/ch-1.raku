sub can-be-made-increasing(@ints) {
    my $count = 0;
    for 1..^@ints.elems -> $i {
        if @ints[$i] <= @ints[$i-1] {
            $count++;
            # If we encounter more than one decreasing element, we can't make the array increasing
            return False if $count > 1;
            
            # Check if removing previous element helps
            return False if $i > 1 && @ints[$i] <= @ints[$i-2];
        }
    }
    return True;
}

# Test the Raku solution
say can-be-made-increasing([0, 2, 9, 4, 6]);  # Expected Output: True
say can-be-made-increasing([5, 1, 3, 2]);    # Expected Output: False
say can-be-made-increasing([2, 2, 3]);       # Expected Output: True

