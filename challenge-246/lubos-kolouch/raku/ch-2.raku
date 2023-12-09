sub is-linear-recurrence(@a) {
    return False if @a.elems < 5;

    # Solving for p and q using the first four elements
    my $denominator = @a[0] * @a[2] - @a[1]**2;
    return False if $denominator == 0;  # Avoid division by zero

    my $p = (@a[2] * @a[3] - @a[1] * @a[4]) / $denominator;
    my $q = (@a[4] - $p * @a[2]) / @a[3];

    # Check if p and q are integers
    return False if $p != $p.Int || $q != $q.Int;

    # Verify the recurrence for the rest of the array
    for 4..^@a.elems -> $i {
        return False if @a[$i] != $p.Int * @a[$i-2] + $q.Int * @a[$i-1];
    }

    return True;
}

# Tests
use Test;
plan 3;
ok is-linear-recurrence([1, 1, 2, 3, 5]), 'Fibonacci sequence';
ok !is-linear-recurrence([4, 2, 4, 5, 7]), 'Even-odd mismatch';
ok is-linear-recurrence([4, 1, 2, -3, 8]), 'Custom sequence';

# Main
say is-linear-recurrence([4, 1, 2, -3, 8]) ?? "true" !! "false";
