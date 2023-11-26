use Test;

sub maximise-greatness(@nums) {
    # Sort the array
    my @sorted-nums = @nums.sort({ $^a <=> $^b });
    
    my $greatness = 0;
    
    for @nums -> $num {
        # Find the first element in sorted-nums that is greater than num
        for 0..^@sorted-nums.elems -> $i {
            if @sorted-nums[$i] > $num {
                $greatness++;
                @sorted-nums.splice($i, 1);
                last;
            }
        }
    }
    return $greatness;
}

plan 2;
is(maximise-greatness([1, 3, 5, 2, 1, 3, 1]), 4, 'Test Case 1');
is(maximise-greatness([1, 2, 3, 4]), 3, 'Test Case 2');

