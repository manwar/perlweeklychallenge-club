#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::MoreUtils qw(slide indexes);

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

say remove_one(@ARGV) ? 'true' : 'false';


### Implementation

# Find the differences between all neighbors and the indices of
# non-positive values thereof.  If there is more than one non-ascending
# step, obviously a strictly increasing order cannot be achieved by
# removing a single element.  OTOH, a single non-ascending step does not
# guarantee a solution.  We may remove either the first or the second
# element from a non-ascending step.  The (negative) difference will
# then be added to either the previous diff or the next.  If neither are
# large enough to compensate for the descent, then there is no solution.
sub remove_one {
    # Get the differences, embraced within infinite values to allow
    # removal of the edge values.
    my @diff = slide {$b - $a} '-inf', @_, 'inf';
    # Get indices of non-ascending steps.
    my @desc = indexes {$_ <= 0} @diff;
    # Succeed if the numbers are strictly ascending.
    return 1 unless @desc;
    # Give up on more than one non-ascent.
    return if @desc > 1;
    # Get the index of the single non-ascending step.
    my $ind = $desc[0];
    # There is a solution if and only if the non-ascending step can be
    # compensated by a neighboring difference.
    return $diff[$ind - 1] > -$diff[$ind] || $diff[$ind + 1] > -$diff[$ind];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  remove_one(0, 2, 9, 4, 6), 'example 1';
        ok !remove_one(5, 1, 3, 2), 'example 2';
        ok  remove_one(2, 2, 3), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok  remove_one(4, 2, 3), 'remove head';
        ok  remove_one(3, 4, 2), 'remove tail';
        ok !remove_one(3, 9, 2, 4), 'both fail'; 
        ok  remove_one(1, 2, 2, 3), 'small plateau';
        ok !remove_one(1, 2, 2, 2, 3), 'large plateau';
	}

    done_testing;
    exit;
}
