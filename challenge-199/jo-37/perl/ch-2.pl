#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS if @ARGV < 5;
usage: $0 [-examples] [-tests]  [X Y Z N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

X Y Z
    limits for absolute pair differences

N1 N2...
    list of values
EOS


### Input and Output

say count_good_3(@ARGV);


### Implementation

# This task may be regarded as a variant of challenge 196/1 and is very
# similar to this week's task 1.  The first transformation step is from
# index i to index j > i having an absolute value difference not
# exceeding X.  The second step goes from index j to index k > j having
# an absolute value difference not exceeding Y. The third step goes from
# index k to index l < k having an absolute value difference not
# exceeding Z, where i shall be equal to l.  The possible starting
# indices then are given by the nonzero elements in the diagonal of the
# resulting product matrix.  Actually, the diagonal has the number of
# solutions for every starting index and thus the sum over the diagonal
# is the requested number of good triplets.
# See
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-196/jo-37/perl/ch-1.pl
# for details.
sub count_good_3 ($x, $y, $z, @l) {
    # Need a "double" piddle capable of holding 'inf' values.
	my $l = pdl @l;
    # Create the matrix of absolute pair differences.
    my $adt = ($l - $l->dummy(0))->abs;
    # Combining the difference matrix and the index transition matrix by
    # invalidating the upper right triangle values (including the
    # diagonal) utilizing symmetry.
    $adt->where($l->sequence >= $l->sequence->dummy(0)) .= 'inf';
        
    # Build transformation matrices and chain them.  Then sum over the
    # diagonal.
    (($adt <= $z)->xchg(0, 1) x ($adt <= $y) x ($adt <= $x))
        ->diagonal(0, 1)->sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_good_3(qw(7 2 3 3 0 1 1 9 7)), 4, 'example 1';
        is count_good_3(qw(0 0 1 1 1 2 2 3)), 0, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        
        is count_good_3(1, 1, 2, 0, 3, 1, 5, 2, 5), 1, 'single triplet';
	}

    done_testing;
    exit;
}
