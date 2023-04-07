#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(forcomb lastfor);
use List::Util qw(sum);
use experimental qw(signatures);

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

say same_average(@ARGV) ? 'true' : 'false';


### Implementation

# It can easily be shown that if two partitions of the list have the
# same average, this common average equals the average of the whole
# list.  Thus all we need to do is find a nonempty true subset of the
# list having the same average as the list.  The complement will have
# the same average.

sub same_average (@list) {
    state $delta = 1e-6;
    my $avg = sum(@list) / @list;
    my $res;
    # Loop over all subsets.
    forcomb {
        # Skip non true subsets.
        return unless @_ && @_ != @list;
        $res = 1, lastfor if abs($avg - sum(@list[@_]) / @_) < $delta;
    } @list;

    $res;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok same_average(1, 2, 3, 4, 5, 6, 7, 8), 'example 1';
        ok !same_average(1, 3), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        ok same_average(1, 1, 1, 1, 5, 9,), '(1 5), (1 1 1 9)';
	}

    done_testing;
    exit;
}
