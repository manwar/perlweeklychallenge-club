use Test;

# Function to calculate the running sum of an array
sub running-sum(@nums) {
    my @result;
    my $sum = 0;

    for @nums -> $num {
        $sum += $num;
        @result.push($sum);
    }

    return @result;
}

# Test cases
is-deeply(running-sum([1, 2, 3, 4, 5]), [1, 3, 6, 10, 15], 'Test Case 1');
is-deeply(running-sum([1, 1, 1, 1, 1]), [1, 2, 3, 4, 5], 'Test Case 2');
is-deeply(running-sum([0, -1, 1, 2]), [0, -1, 0, 2], 'Test Case 3');

done-testing;
