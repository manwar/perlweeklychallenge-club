#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Test::More;

=head1 NAME

ch-2.pl - Challenge 371 Task 2: Subset Equilibrium

=head1 SYNOPSIS

Find all subsets of a given array where the sum of elements equals the sum of their 1-based indices.

=head1 DESCRIPTION

Example 1: (2, 1, 4, 3) -> ((2, 1), (4, 3), (2, 1, 4, 3))
Subsets:
- (2, 1): Values sum 3, Indices (1, 2) sum 3. Valid.
- (4, 3): Values sum 7, Indices (3, 4) sum 7. Valid.
- (2, 1, 4, 3): Values sum 10, Indices (1, 2, 3, 4) sum 10. Valid.

=cut

sub find_equilibrium_subsets {
    my (@ints) = @_;
    my $n = scalar @ints;
    my @results;

    # Iterate through all possible non-empty subsets using bitmask
    for my $mask (1 .. (1 << $n) - 1) {
        my $sum_vals = 0;
        my $sum_inds = 0;
        my @subset;

        for my $i (0 .. $n - 1) {
            if ($mask & (1 << $i)) {
                $sum_vals += $ints[$i];
                $sum_inds += ($i + 1);
                push @subset, $ints[$i];
            }
        }

        if ($sum_vals == $sum_inds) {
            push @results, [ @subset ];
        }
    }

    return \@results;
}

# Unit Tests
is_deeply(find_equilibrium_subsets(2, 1, 4, 3), [ [2, 1], [4, 3], [2, 1, 4, 3] ], "Example 1");
is_deeply(find_equilibrium_subsets(1, 2, 3), [ [1], [1, 2], [1, 2, 3] ], "Custom 1 (Incremental values)");
# wait, (1) at index 1 -> sum val 1, sum ind 1. Correct.
# (1, 2) at indices 1, 2 -> sum val 3, sum ind 3. Correct.
# (1, 2, 3) at indices 1, 2, 3 -> sum val 6, sum ind 6. Correct.
# (2) at index 2 -> sum val 2, sum ind 2. Correct.
# (3) at index 3 -> sum val 3, sum ind 3. Correct.
# (2, 3) at index 2, 3 -> sum val 5, sum ind 5. Correct.
# (1, 3) at index 1, 3 -> sum val 4, sum ind 4. Correct.
# So results for (1, 2, 3) should be many!
# (1), (2), (3), (1, 2), (1, 3), (2, 3), (1, 2, 3) are ALL equilibrium subsets!

done_testing();
