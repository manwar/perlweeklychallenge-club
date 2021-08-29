#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'pairs';
use List::MoreUtils 'any';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [l1 u1 l2 u2 ... lN uN]

-examples
    run the examples from the challenge
 
-tests
    run some tests

l1 u1 l2 u2 ... lN uN
    lower and upper bounds for intervals [li, ui)

EOS


### Input and Output

say "(@$_)" for conflicting_intervals(pairs @ARGV);


### Implementation

# This task is ambiguous.  It is not specified if the intervals shall be
# considered as open, closed or half-open.  The meaning of "conflicting
# intervals" also remains unspecified.  The examples' explanations
# suggest that intervals are conflicting if they overlap but are not in
# a subset relation, particularly because there seems to be no conflict
# between (3, 20) and any of (3, 5), (6, 8) and (12, 13).
# Making these assumptions:
# - intervals are half-open [a, b)
# - an interval [a, b) having b ≤ a is empty
# - two intervals are not conflicting if one is a subset of the other
#   or their intersection is empty.

# There is a conflict between [i0, i1) and [k0, k1) if
# i0 < k0 < i1 < k1 or
# k0 < i0 < k1 < i1
sub conflicting ($i, $k) {
    $_->[0][0] < $_->[1][0] &&
    $_->[1][0] < $_->[0][1] &&
    $_->[0][1] < $_->[1][1] &&
    return 1 for [$i, $k], [$k, $i];
}

# Traversing backwards seems to be a bit easier to handle.
sub conflicting_intervals (@intervals) {
    my @conflicts;
    while (defined (my $i = pop @intervals)) {
        unshift @conflicts, $i if any {conflicting($_, $i)} @intervals;
    }
    @conflicts;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [conflicting_intervals([1, 4], [3, 5], [6, 8], [12, 13], [3, 20])],
            [[3, 5], [3, 20]], 'example 1';
        is [conflicting_intervals([3, 4], [5, 7], [6, 9], [10, 12], [13, 15])],
            [[6, 9]], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        # Let
        # [i₀, i₁) ≤ [k₀, k₁) if i₁ ≤ k₀
        # [i₀, i₁) < [k₀, k₁) if i₁ < k₀ etc.
        is conflicting([0, 1], [0, 1]), F(), 'i = k';
        is conflicting([0, 1], [1, 2]), F(), 'i ≤ k';
        is conflicting([1, 2], [0, 1]), F(), 'i ≥ k';
        is conflicting([0, 1], [2, 3]), F(), 'i < k';
        is conflicting([2, 3], [0, 1]), F(), 'i > k';
        is conflicting([1, 2], [0, 3]), F(), 'i ⊂ k';
        is conflicting([0, 3], [1, 2]), F(), 'i ⊃ k';
        is conflicting([0, 1], [0, 2]), F(), 'i ⊂ k, i₀ = k₀';
        is conflicting([0, 2], [0, 1]), F(), 'i ⊃ k, i₀ = k₀';
        is conflicting([1, 2], [0, 2]), F(), 'i ⊂ k, i₁ = k₁';
        is conflicting([0, 2], [1, 2]), F(), 'i ⊃ k, i₁ = k₁';
        is conflicting([2, 1], [0, 3]), F(), 'i = ∅';
        is conflicting([0, 3], [2, 1]), F(), 'k = ∅';
        is conflicting([0, 2], [3, 1]), F(), 'k = ∅';
        is conflicting([3, 1], [0, 2]), F(), 'i = ∅';
        is conflicting([3, 2], [0, 1]), F(), 'i = ∅, i > k';
        is conflicting([0, 1], [3, 2]), F(), 'k = ∅, i < k';
        is conflicting([1, 0], [2, 3]), F(), 'i = ∅, i < k';
        is conflicting([2, 3], [1, 0]), F(), 'k = ∅, i > k';
        is conflicting([0, 2], [1, 3]), T(),
            'conflict: i ⊈ k, i ≰ k, i ⊉ k, i ≱ k';
        is conflicting([1, 3], [0, 2]), T(),
            'conflict: i ⊈ k, i ≰ k, i ⊉ k, i ≱ k';

        is [conflicting_intervals([3, 5], [6, 8], [12, 13], [3, 20])],
            [], 'example 1 without the conflicting (1, 4)';
        is [conflicting_intervals([0, 1], [1, 2], [2, 3])], [],
            'lined up';
        is [conflicting_intervals([1, 2], [0, 4])], [],
            'contained';
        is [conflicting_intervals([0, 2], [1, 1])], [],
            'non conflicting empty interval';
        is [conflicting_intervals([1, 1], [0, 2])], [],
            'non conflicting empty interval';
	}

    done_testing;
    exit;
}
