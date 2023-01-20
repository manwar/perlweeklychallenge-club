#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use experimental 'postderef';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

main: {
    local $" = ',';
    local $, = ', ';
    say map "(@$_)", arith_slices(@ARGV);
}


### Implementation

# Using PDL to solve the task.  Overkill, once again.

# Some details remain unspecified:
# - the presentation order of the found arithmetic slices
# - the treatment of different subslices having the same values
# This implementation does:
# - order maximal arithmetic slices by starting index
# - find subslices by increasing length and by starting index within the
#   same length
# - regard subslices having a different starting index or length as
#   different, regardless of the values therein.

sub arith_slices {
    return if @_ < 3;
    my $l = long @_;

    # Calculate differences between consecutive pairs and run-length
    # encode these.  Only the run lengths are required, the differences
    # get dropped.
    my ($rl) = rle $l(1:-1) - $l(0:-2);
    
    # The starting indices of each run can be found by taking the
    # cumulative sums over the run lengths starting with zero.
    # There are several way to calculate the zero-based cumulative sums.
    # One of them is to take the difference between the total sum and
    # the reversed cumulative sums over the reversed list, as can be
    # seen from this example:
    # (a, b, c) -> ((a + b + c) - (c + b + a), (a + b + c) - (c + b),
    # (a + b + c) - c) = (0, a, a + b)
    # The total sum over the run length equals the length of the list of
    # differences which is one less than the original list's length.
    my $idx = $l->dim(0) - 1 - $rl(-1:0)->cumusumover->(-1:0);

    # The differences' run lengths are one below the subarray lengths,
    # adjust them.
    $rl += 1;

    # Select subarrays having a minimum length of three, given by their
    # starting index and their length.
    my @res;
    for my $il (cat(where $idx, $rl, $rl > 2)->xchg(0, 1)->dog) {
        # Pick a maximal arithmetic array slice given by index and
        # lenght.
        my $maas = $l->range($il->list);

        # Split each maximal arithmetic array slice into all requested
        # array slices and collect these.
        push @res, map $maas->lags(0, 1, $_)
            ->xchg(0, 1)->(-1:0)->unpdl->@*, 3 .. $maas->dim(0);
    }

    @res;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [arith_slices(1, 2, 3, 4)],
            [[1, 2, 3], [2, 3, 4], [1, 2, 3, 4]], 'example 1';

        is [arith_slices(2)], [], 'example 2';

    }

    SKIP: {
        skip "tests" unless $tests;

        is [arith_slices(1, 2, 3, 4, 3, 5, 7)],
            [[1, 2, 3], [2, 3, 4], [1, 2, 3, 4], [3, 5, 7]],
            'different step sizes';

        is [arith_slices(-2, 0, 2)], [[-2, 0, 2]], 'negative value';

        is [arith_slices(1, 2, 3, 5, 7)], [[1, 2, 3], [3, 5, 7]],
            'adjacent slices';

        is [arith_slices(0, 0, 0, 0)], [[0, 0, 0], [0, 0, 0], [0, 0, 0, 0]],
            'slices having equal values';
	}

    done_testing;
    exit;
}
