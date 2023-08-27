#!/usr/bin/perl -s

use v5.26;
use Test2::V0;
use experimental 'signatures';
use Data::Dump;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of distinct numbers

EOS


### Input and Output

main: {
    my @not_extreme = not_extreme(@ARGV);
    say @not_extreme ? "(@{[@not_extreme]})" : -1;
}


### Implementation

# After having solved task 1, I couldn't stop thinking about the
# prerequisite of the given numbers being distinct.  Finally found a use
# for it: For distinct numbers the task may be accomplished in a single
# pass.
# Looping over the numbers:
# - Take the first element as the current minimum and maximum.
# - If the current number is a new minimum or maximum, restore the
#   previous recorded minimum or maximum unless it was the first element
#   of the list and then record the new minimum or maximum along with
#   its index in the resulting list.
# - Pass any non-extreme values to the resulting list.
# Finally, put the first element of the input list to the front of the
# resulting list if it is not an extremum.

sub not_extreme {

    # Record an extremum and restore the previous value unless it is the
    # first from the list.
    state sub rec_ext :prototype($$\$\$\@) ($n, $first, $ext, $ind, $res) {
        if ($$ext != $first) {
            splice @$res, $$ind, 0, $$ext;
        }
        ($$ext, $$ind) = ($n, scalar @$res);
    }

	my ($min, $max, $min_ind, $max_ind, @res);

    for my $n (@_) {
        if ($n == $_[0]) {
            # Initialize min and max with the first element.
            ($min, $min_ind) = ($max, $max_ind) = ($n, 0);
        } elsif ($n < $min) {
            # Record a new minimum
            rec_ext($n, $_[0], $min, $min_ind, @res);
        } elsif ($n > $max) {
            # Record a new maximum
            rec_ext($n, $_[0], $max, $max_ind, @res);
        } else {
            # Pass a non-extreme value.
            push @res, $n;
        }
    }
    # Prepend a non-extreme first element.
    unshift @res, $_[0] if $_[0] < $max && $_[0] > $min;

    @res;
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

        is [not_extreme(2, 1)], [], 'max before min';
        is [not_extreme(1, 2)], [], 'min before max';
        is [not_extreme(4, 3, 2, 1)], [3, 2],
            'max before min, keep sequence';
        is [not_extreme(1, 3, 2, 4)], [3, 2], 
            'min before max, keep sequence';
        is [not_extreme(1)], [], 'single value';
	}

    done_testing;
    exit;
}
