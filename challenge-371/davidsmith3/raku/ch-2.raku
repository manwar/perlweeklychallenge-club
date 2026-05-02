#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 371 Task 2 Subset Equilibrium
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given an array of numbers.

Write a script to find all proper subsets with more than one element where the sum of elements equals the sum of their indices.

=head3 Example 1:
Input: @nums = (2, 1, 4, 3)
Output: (2, 1), (1, 4), (4, 3), (2, 3)

Subset 1: (2, 1)
Values: 2 + 1 = 3
Positions: 1 + 2 = 3

Subset 2: (1, 4)
Values: 1 + 4 = 5
Positions: 2 + 3 = 5

Subset 3: (4, 3)
Values: 4 + 3 = 7
Positions: 3 + 4 = 7

Subset 4: (2, 3)
Values: 2 + 3 = 5
Positions: 1 + 4 = 5

=head3 Example 2:
Input: @nums = (3, 0, 3, 0)
Output: (3, 0), (3, 0, 3)

Subset 1: (3, 0)
Values: 3 + 0 = 3
Positions: 1 + 2 = 3

Subset 2: (3, 0, 3)
Values: 3 + 0 + 3 = 6
Positions: 1 + 2 + 3 = 6

=head3 Example 3:
Input: @nums = (5, 1, 1, 1)
Output: (5, 1, 1)

Subset 1: (5, 1, 1)
Values: 5 + 1 + 1 = 7
Positions: 1 + 2 + 4 = 7

=head3 Example 4:
Input: @nums = (3, -1, 4, 2)
Output: (3, 2), (3, -1, 4)

Subset 1: (3, 2)
Values: 3 + 2 = 5
Positions: 1 + 4 = 5

Subset 2: (3, -1, 4)
Values: 3 + (-1) + 4 = 6
Positions: 1 + 2 + 3 = 6

=head3 Example 5:
Input: @nums = (10, 20, 30, 40)
Output: ()

=end pod

sub my-sub(@nums where .all ~~ Int --> Array) {
    my @result;
    
    # minimum length is 2, maximum length is one less than the length of original to be proper subset
    my @lengths = 2..^@nums.elems;

    # positions are 1-based indices
    my @positions = 1..@nums.elems;
    
    for @lengths -> $length {
        for @positions.combinations($length) -> $candidate {
            my $elements = $candidate.sort.map({ @nums[$_ - 1] }).List;
            @result.push($elements) if $candidate.sum == $elements.sum;
        }
    }
    @result;
}

#| find subsets with equilibrium from a comma separated list of numbers
multi MAIN(Str:D $nums) {
    say my-sub($nums.split(',').map({ .Int }).List);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%{ input => (2, 1, 4, 3), output => ((2, 1), (1, 4), (4, 3), (2, 3)) });
    @tests.push(%{ input => (3, 0, 3, 0), output => ((3, 0), (3, 0, 3)) });
    @tests.push(%{ input => (5, 1, 1, 1), output => ((5, 1, 1),) });
    @tests.push(%{ input => (3, -1, 4, 2), output => ((3, 2), (3, -1, 4)) });
    @tests.push(%{ input => (10, 20, 30, 40), output => () });
    @tests.push(%{ input => (), output => () });
    @tests.push(%{ input => (1, ), output => () });
    @tests.push(%{ input => (1, 2, 1), output => ((1, 2),) });

    plan +@tests;
    for @tests {
        is-deeply my-sub(.<input>).sort, .<output>.sort, "{.<input>}";
    }
}
