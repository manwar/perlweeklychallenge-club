use Test;

sub construct-matrix(@a) {
    my @b;
    for 0..@a.end - 1 -> $i {
        for 0..@a[$i].end - 1 -> $k {
            @b[$i][$k] = @a[$i][$k] + @a[$i][$k + 1] + @a[$i + 1][$k] + @a[$i + 1][$k + 1];
        }
    }
    return @b;
}

# Test Cases
is-deeply construct-matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]),
          [[14, 18, 22], [30, 34, 38]], 'Test Case 1';

is-deeply construct-matrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]),
          [[2, 1, 0], [1, 2, 1], [0, 1, 2]], 'Test Case 2';

done-testing();
