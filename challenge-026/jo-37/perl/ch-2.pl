#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use warnings;
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [D...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

D...
    angles (in degrees)

EOS


### Input and Output

say angle_mean(@ARGV);


### Implementation

use constant DEG2RAD => atan2(1,1) / 45;

sub angle_mean {
	my $r = DEG2RAD * pdl @_;
    atan2($r->sin->average, $r->cos->average) / DEG2RAD;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is angle_mean(355, 5, 15), 5, 'example from Wiki';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
