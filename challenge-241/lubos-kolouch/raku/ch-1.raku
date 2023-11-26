sub count-arithmetic-triplets(@nums, $diff) {
    my $count = 0;
    my %nums-set = @nums.Set;

    for @nums -> $num {
        if %nums-set{$num + $diff}:exists {
            if %nums-set{$num - $diff}:exists {
                $count++;
            }
        }
    }

    return $count;
}

# Test Cases
say count-arithmetic-triplets([0, 1, 4, 6, 7, 10], 3);  # Should print 2
say count-arithmetic-triplets([4, 5, 6, 7, 8, 9], 2);  # Should print 2
