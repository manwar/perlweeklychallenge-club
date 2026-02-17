#!/usr/bin/perl
use strict;
use warnings;
# You are given a binary matrix (m x n) where m = n.

# A celebrity is defined as someone who:
# 1. Knows nobody, i.e. their entire row in the matrix consists only of zeros.
# 2. Is known by everyone else, i.e. their column consists only of ones, excluding
#    the celebrity's own position.

# The function iterates over all people and checks these two conditions using grep,
# which is a natural choice for filtering tasks in Perl:
# 1. The first grep verifies that the candidate's row contains no non-zero entries.
# 2. The second grep verifies that no other person fails to know the candidate.

# If both conditions are met, the index is returned immediately; otherwise,
# the function returns -1.

# This implementation is concise and relies only on core Perl features. A solution
# using modules such as List::MoreUtils would also be possible, but the grep approach
# keeps the logic transparent and self-contained.

sub find_celebrity {
    # $m is a reference to an n × n matrix.
    my ($m) = @_;
    my $n = @$m;

    for my $i (0 .. $n-1) {
        # candidate knows nobody (row all zeros)
        next if (grep { $_ != 0 } @{$m->[$i]});

        # everyone else knows candidate (column all ones except self)
        next if (grep { $_ != $i && $m->[$_][$i] != 1 } 0 .. $n-1);

        # passed both checks, candidate is a celebrity
        return $i;
    }

    # no celebrity found
    return -1;
}


# Tests

my @party;

# Example 1
@party = (
             [0, 0, 0, 0, 1, 0],
             [0, 0, 0, 0, 1, 0],
             [0, 0, 0, 0, 1, 0],
             [0, 0, 0, 0, 1, 0],
             [0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 1, 0]
         );
printf "%d\n", find_celebrity(\@party); # Output: 4

# Example 2
@party = (
             [0, 1, 0, 0],
             [0, 0, 1, 0],
             [0, 0, 0, 1],
             [1, 0, 0, 0]
         );
printf "%d\n", find_celebrity(\@party); # Output: -1

# Example 3
@party = (
             [0, 0, 0, 0, 0],
             [1, 0, 0, 0, 0],
             [1, 0, 0, 0, 0],
             [1, 0, 0, 0, 0],
             [1, 0, 0, 0, 0]
         );
printf "%d\n", find_celebrity(\@party); # Output: 0

# Example 4
@party = (
             [0, 1, 0, 1, 0, 1],
             [1, 0, 1, 1, 0, 0],
             [0, 0, 0, 1, 1, 0],
             [0, 0, 0, 0, 0, 0],
             [0, 1, 0, 1, 0, 0],
             [1, 0, 1, 1, 0, 0]
         );
printf "%d\n", find_celebrity(\@party); # Output: 3

# Example 5
@party = (
             [0, 1, 1, 0],
             [1, 0, 1, 0],
             [0, 0, 0, 0],
             [0, 0, 0, 0]
         );
printf "%d\n", find_celebrity(\@party); # Output: -1

# Example 6
@party = (
            [0, 0, 1, 1],
            [1, 0, 0, 0],
            [1, 1, 0, 1],
            [1, 1, 0, 0]
      );
printf "%d\n", find_celebrity(\@party); # Output: -1
