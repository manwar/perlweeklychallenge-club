#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Data::Dump;
use experimental qw(signatures smartmatch);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N11,...N1x N21,...,N2y ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1x,...N1y ... 
    List of list of items
    Call "$0 1,2 3,4 5,6 1,2" for example 1.

EOS


### Input and Output

# Not even thinking about trying to format the content of a list of array
# refs.
dd uniq_arr(map [split /,/], @ARGV);


### Implementation

# What could it mean: "remove duplicate arrayrefs from the given list"?
# From the example it is clear that not only references to the same
# array are meant to be removed, but references to "identical" arrays,
# too.  An array may contain virtually anything and hence a "duplicate
# arrayref" can only mean two references to arrays holding identical
# content, i.e. "deep copies" of each other.  Here the smartmatch
# operator comes handy: for array(-ref)s it checks if the left hand side
# is "contained" in the right hand side.  If both checks $x ~~ $y and $y
# ~~ $x are true, both arrays represent the same data, or in the sense
# of this task they are "duplicates".  Here we cannot find duplicates
# the usual way by the usage of hashes because this approach requires a
# unique strings representation.  So we acutually need to perform an
# expensive O(N²) pairwise comparison.
sub uniq_arr (@arr) {
    for my $i (0 .. $#arr - 1) {
        # Skip already identified duplicates.
        next unless defined $arr[$i];
        for my $k ($i + 1 .. $#arr) {
            # Mark duplicates.
            undef $arr[$k] if $arr[$i] ~~ $arr[$k] && $arr[$k] ~~ $arr[$i];
        }
    }
    # Filter dups.
    grep defined, @arr;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [uniq_arr([1,2], [3,4], [5,6], [1,2])],
        [[1,2], [3,4], [5,6]], 'example 1';

        is [uniq_arr([9,1], [3,7], [2,5], [2,5])],
        [[9, 1], [3,7], [2,5]], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [uniq_arr([1, [2, 3]], [1, [2, 3]], [1, 2, 3], [{a => 1}])],
        [[1, [2, 3]], [1, 2, 3 ], [{a => 1}]], 'nested arrays and hashes';
	}

    done_testing;
    exit;
}
