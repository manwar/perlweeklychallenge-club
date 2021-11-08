#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 8;
usage: $0 [-examples] [-tests] [x1 y1 ... x4 y4]

-examples
    run the examples from the challenge
 
-tests
    run some tests

x1 y1 ... x4 y4
    four x-y vertex coordinate pairs forming a tetragon

EOS


### Input and Output

say 0 + is_square(v(@ARGV[0,1]), v(@ARGV[2,3]), v(@ARGV[4,5]), v(@ARGV[6,7]));


### Implementation

# Check if four (2-d) vertices form a square.
# A square is a rectangle with all edges of the same length.  If a
# tetragon has three 90° angles, the fourth must have 90°, too.  So
# checking for three angles is sufficient for a rectangle.  Furthermore,
# the opposite edges in an rectangle have the same length. Thus checking
# any two neighboring edges for the same length is sufficient for a
# square.
# Using PDL just for its nice vector operations.

sub is_square ($v1, $v2, $v3, $v4) {
    # Transform vertex vectors to edge vectors.
    my ($e1, $e2, $e3, $e4) = ($v2 - $v1, $v3 - $v2, $v4 - $v3, $v1 - $v4);

    # Check three angles and two lengths.
    !any pdl $e1->transpose x $e2,
        $e2->transpose x $e3,
        $e3->transpose x $e4,
        $e1->transpose x $e1 - $e2->transpose x $e2;
}

# Create a column vector as 1xN piddle
sub v (@p) {
    pdl(@p)->dummy(0);
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is is_square(v(10, 20), v(20, 20), v(20, 10), v(10, 10)),
            T(), 'example 1';
        is is_square(v(12, 24), v(16, 10), v(20, 12), v(18, 16)),
            F(), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is is_square(v(10, 20), v(21, 21), v(20, 10), v(10, 10)),
            F(), 'e1/e2 not ortogonal';
        is is_square(v(10, 20), v(20, 20), v(21, 11), v(10, 10)),
            F(), 'e2/e3 not ortogonal';
        is is_square(v(10, 20), v(20, 20), v(20, 10), v(11, 11)),
            F(), 'e3/e4 not ortogonal';
        is is_square(v(11, 21), v(20, 20), v(20, 10), v(10, 10)),
            F(), 'e4/e1 not ortogonal';
        is is_square(v(10, 20), v(21, 20), v(21, 10), v(10, 10)),
            F(), 'unequal edge lengths';
        is is_square(v(1, 1), v(3, 2), v(2, 4), v(0, 3)), T(),
            'rotated';

        my $u = sqrt(2);
        my $v = sqrt(5);
        is is_square(v($u, $v), v($v, $v), v($v, $u), v($u, $u)),
            T(), 'floating point vertice coordinates'; 
	}

    done_testing;
    exit;
}
