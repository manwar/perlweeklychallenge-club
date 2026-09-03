#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 389 Task 2

Submitted by: Roger Bell_West
=head2 ZigZag Subarray

You are given an array of integers.

Write a script to find the length of the longest contiguous subarray where the numbers alternate between strictly increasing and strictly decreasing (a ZigZag pattern).

A sequence of numbers $A = [a0, a1, …, ak]$ with length $k >= 1 is considered a ZigZag sequence if every adjacent pair alternates direction:

a_0 < a_1 > a_2 < a_3 > ...
OR
a_0 > a_1 < a_2 > a_3 < ...

NOTE: A single element (length 1) or any two distinct elements (length 2) are automatically valid ZigZag sequences. Equal adjacent numbers (e.g., 5, 5) break the pattern.


=head3 Example 1:

Input: @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9)
Output: 5

ZigZag subarray: (4, 2, 10, 7, 8)

=head3 Example 2:

Input: @nums = (1, 7, 4, 9, 2, 5)
Output: 6

ZigZag subarray: (1, 7, 4, 9, 2, 5)

=head3 Example 3:

Input: @nums = (1, 2, 3, 4, 5)
Output: 2

ZigZag subarray: (1, 2)

=head3 Example 4:

Input: @nums = (4, 4, 4)
Output: 1

=head3 Example 5:

Input: @nums = (10, 20, 15, 12, 18)
Output: 3

ZigZag subarray: (10, 20, 15)

=end pod

multi zigzag-subarray(@nums where .elems > 0 && .all ~~ Int:D --> Int) {
    my @subarrays;                                           # contains all start and end zigzag subarray indexes
    @subarrays.push(0);                                      # after we traverse the array, we will compute the
    my $prev = @nums[0];                                     # length of each span and return the max
    my $prev-direction = Same;
    my $i = 1;
    while $i < @nums.elems {
        my $curr = @nums[$i];
        my $curr-direction = $curr <=> $prev;
        given ($prev-direction, $curr-direction) {
            when (*, Same) {                                 # . . 4 4 . .
                @subarrays.push($i - 1);                     #     ^        end of subarray
                @subarrays.push($i);                         #       ^      start of next
            }

            when $prev-direction eqv $curr-direction {       # . 2 3 4 . .
                @subarrays.push($i - 1);                     #     ^        start and end are coincident
                @subarrays.push($i - 1);
            }
        }
        $prev-direction = $curr-direction;
        $prev = $curr;
        $i++;
    }
    @subarrays.push($i - 1);
    @subarrays.map(-> $left, $right { $right - $left }).max + 1;
}

multi zigzag-subarray(@nums) {
    die "Expecting a sequence of integers.  Received { @nums }.";
}

#| returns the length of the longest zigzag subarray
multi MAIN(*@nums) {
    say zigzag-subarray(@nums);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (9, 4, 2, 10, 7, 8, 8, 1, 9), output => 5));
    @tests.push(%( input => (1, 7, 4, 9, 2, 5), output => 6));
    @tests.push(%( input => (1, 2, 3, 4, 5), output => 2));
    @tests.push(%( input => (4, 4, 4), output => 1));
    @tests.push(%( input => (10, 20, 15, 12, 18), output => 3));
    @tests.push(%( input => (1,), output => 1));
    @tests.push(%( input => (1, 2), output => 2));
    @tests.push(%( input => (2, 1), output => 2));
    @tests.push(%( input => (1, 1), output => 1));
    @tests.push(%( input => (1, 1, 2), output => 2));
    @tests.push(%( input => (2, 1, 1), output => 2));
    @tests.push(%( input => (1, 2, 3), output => 2));
    @tests.push(%( input => (1, 2, 3, 2, 1), output => 3));

    my @should-throw;
    @should-throw.push(%( input => (1, 2, "a") ));
    @should-throw.push(%( input => () ));

    plan @tests + @should-throw + 3;
    for @tests {
        is zigzag-subarray(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { zigzag-subarray(.<input>) }, Exception, "dies on { .<input> }", message => /Expecting/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1', '2', :out, :err);
    is $proc.out.slurp(:close).trim, '2', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
