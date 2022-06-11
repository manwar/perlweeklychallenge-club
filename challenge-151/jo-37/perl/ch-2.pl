#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'max';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [V1 V2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

V1 V2...
    Valuables at each house

EOS


### Input and Output

say grand_raid(@ARGV);


### Implementation

# The grand raid must end at the last or second last house.  Otherwise
# there was another house left to be robbed.  Stepping backward by
# adding the valuables at the current house to the booties available
# from there.  The found booties at the first house make the grand raid.
sub grand_raid (@valuables) {
    my @booties;
    # For each house, add the valuables therein to the maximum booties
    # available from there.
    for (my $house = $#valuables; $house >= 0; $house--) {
        $booties[$house] = $valuables[$house] +
            max 0, @booties[$house + 2 .. $#booties];
    } 

    $booties[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is grand_raid(2, 4, 5), 7, 'example 1';
        is grand_raid(4, 2, 3, 6, 5, 3), 13, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is grand_raid(1), 1, 'only one house';
        is grand_raid(2, 1), 2, 'two houses, first is best';
        is grand_raid(1, 2), 1, 'two houses, second is best';
	}

    done_testing;
    exit;
}
