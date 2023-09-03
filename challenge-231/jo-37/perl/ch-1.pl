#!/usr/bin/perl -s

use v5.26;
use Test2::V0;
use experimental 'signatures';

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
    my @not_extreme = not_extreme(@ARGV);
    say @not_extreme ? "(@{[@not_extreme]})" : -1;
}


### Implementation

# Find all elements in a list that are not extreme values in three
# steps:
# - Identify the minimum and maximum values along with theirs indices in
#   the list.
# - Delete all extreme values from the list.
# - 'grep' for the remaining 'defined' values.
# With this procedure, there is only little extra effort needed to
# extend the task to non-unique values.  Thus dropping the uniqueness
# requirement.
#
# PS: See ch-1a.pl for a one-pass solution utilizing the numbers'
# uniqueness

sub not_extreme {
    # Lexical sub that records extreme values along with their indices.
    # The parameters are:
    # - $i, $n: index and value of the current list element
    # - $ext, @ind: current extremum and its corresponding indices (may
    #   be modified)
    # - $cmp: type of extremum (1 => maximum, -1 => minimum)
    state sub rec_ext :prototype($$\$\@$) ($i, $n, $ext, $ind, $cmp) {
        if (($n <=> $$ext) == $cmp) {
            ($$ext, @$ind) = ($n, $i);
        } elsif ($n == $$ext) {
            push @$ind, $i;
        }
    }

	my ($min, $max, @min_ind, @max_ind) = ('inf', '-inf');

    # Loop over the array and record all minima and maxima.
    while (my ($i, $n) = each @_) {
        rec_ext($i, $n, $min, @min_ind, -1);
        rec_ext($i, $n, $max, @max_ind, 1);
    }
    # Remove trailing extrema and 'undef' others.
    delete @_[@min_ind, @max_ind];

    # Return the remainder.
    grep defined, @_
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [not_extreme(3, 2, 1, 4)], [3, 2], 'example 1';
        is [not_extreme(3, 1)], [], 'example 2';
        is [not_extreme(2, 1, 3)], [2], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [not_extreme(2, 2, 1, 1)], [], 'max before min';
        is [not_extreme(1, 1, 2, 2)], [], 'min before max';
        is [not_extreme(4, 4, 3, 2, 1, 1)], [3, 2],
            'max before min, keep sequence';
        is [not_extreme(1, 1, 3, 2, 4, 4)], [3, 2], 
            'min before max, keep sequence';
        is [not_extreme(1, 1, 1)], [], 'all the same';
	}

    done_testing;
    exit;
}
