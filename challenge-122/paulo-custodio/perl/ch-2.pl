#!/usr/bin/env perl

# TASK #2 > Basketball Points
# Submitted by: Mohammad S Anwar
# You are given a score $S.
#
# You can win basketball points e.g. 1 point, 2 points and 3 points.
#
# Write a script to find out the different ways you can score $S.
#
# Example
# Input: $S = 4
# Output: 1 1 1 1
#         1 1 2
#         1 2 1
#         1 3
#         2 1 1
#         2 2
#         3 1
#
# Input: $S = 5
# Output: 1 1 1 1 1
#         1 1 1 2
#         1 1 2 1
#         1 1 3
#         1 2 1 1
#         1 2 2
#         1 3 1
#         2 1 1 1
#         2 1 2
#         2 2 1
#         2 3
#         3 1 1
#         3 2

use Modern::Perl;
use List::Util 'sum';

my $N = shift||0;
show_scores($N);

sub show_scores {
    my($N, @points) = @_;
    my $s = @points ? sum(@points) : 0;
    if ($s > $N) {
    }
    elsif ($s == $N) {
        say "@points";
    }
    else {
        show_scores($N, @points, 1);
        show_scores($N, @points, 2);
        show_scores($N, @points, 3);
    }
}
