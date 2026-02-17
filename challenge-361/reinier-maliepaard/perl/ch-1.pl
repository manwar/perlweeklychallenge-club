#!/usr/bin/perl
use strict;
use warnings;

# Memory-Efficient Zeckendorf Representation
# This implementation computes the Zeckendorf representation (unique sum of non-consecutive
# Fibonacci numbers) without building a Fibonacci array.
# Instead of storing the whole sequence up to n, it keeps only two consecutive Fibonacci
# numbers at a time. These two variables are enough to:
# - Move forward to find the largest Fibonacci number ≤ n.
# - Then move backward through the Fibonacci numbers while subtracting (when possible).
# Because the Fibonacci recurrence only depends on the two previous values, no additional
# storage is necessary.

# Advantages:
# - Minimal memory: only two consecutive Fibonacci numbers are stored.
# - Fast: each step subtracts a large Fibonacci number, so the loop runs roughly log(n) times.
# - Easy to understand: no complex array management or extra trimming needed.

# A short and simple example with n = 10:

# Step 1: Find largest Fibonacci ≤ 10
# Fibonacci numbers: 1, 2, 3, 5, 8, 13
# Largest less than or equal to 10: 8

# Step 2: Move backward and subtract
# 8 less than or equal to 10, subtract, remainder = 2
# 5 > 2: skip
# 3 > 2: skip
# 2 less than or equal to 2, subtract, remainder = 0

# Result
# 10 = 8 + 2

sub zeckendorf {
    my ($n) = @_; # original number
    die "Input must be positive\n" if ($n <= 0);

    # Step 1: find largest Fibonacci number <= n
    my ($fib_prev, $fib_curr) = (1, 2);
    ($fib_prev, $fib_curr) = ($fib_curr, $fib_prev + $fib_curr) while ($fib_curr <= $n);

    # Step 2: move backward and subtract when possible
    my $remainder = $n; # leftover value as we subtract
    my @result;

    while ($fib_prev > 0) {
        if ($fib_prev <= $remainder) {
            push (@result, $fib_prev);
            $remainder -= $fib_prev;
        }
        ($fib_prev, $fib_curr) = ($fib_curr - $fib_prev, $fib_prev);
    }

    return @result;
}

# Tests
my $int;

# Example 1
$int = 4;
printf "%s\n", join ", ", zeckendorf($int); # Output: 3, 1

# Example 2
$int = 12;
printf "%s\n", join ", ", zeckendorf($int); # Output: 8, 3, 1

# Example 3
$int = 20;
printf "%s\n", join ", ", zeckendorf($int); # Output: 13, 5, 2

# Example 4
$int = 96;
printf "%s\n", join ", ", zeckendorf($int); # Output: 89, 5, 2

# Example 5
$int = 100;
printf "%s\n", join ", ", zeckendorf($int); # Output: 89, 8, 3
