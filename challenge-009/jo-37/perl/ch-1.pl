#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen;
use Math::Prime::Util 'todigits';
use List::Util 'uniq';
use experimental 'signatures';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    process numbers in base B

N
    find the first square having at least N different digits in base B.

EOS


### Input and Output

say gen_squares(shift, $base)->();

### Implementation


# Build a generator for square numbers having at least $n different
# digits in base $base.
sub gen_squares ($n, $base) {
    <1..>->map('**2')->filter(sub{uniq(todigits($_, $base)) >= $n});
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
    }

    SKIP: {
        skip "tests" unless $tests;

        is gen_squares(5, 10)->take(20),
        [12769, 13456, 13689, 13924, 15376, 15876, 16384, 17689, 17956,
            18496, 18769, 20164, 20736, 21609, 21904, 23104, 23409, 23716,
            28561, 29584], 'from A235720';
	}

    done_testing;
    exit;
}
