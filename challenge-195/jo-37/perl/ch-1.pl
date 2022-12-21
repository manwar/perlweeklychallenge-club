#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen;
use Math::Prime::Util 'todigitstring';
use experimental qw(signatures);

our ($tests, $examples, $verbose, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-base=B] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print all special integers up to N in base B instead of counting them

-base=B
    consider special integers in base B <= 36. Default: 10

N
    find or count special integers in base B up to (decimal) N

EOS


### Input and Output

main: {
    my $gsi = gen_spec_int(shift, $base);
    $verbose ? $gsi->say : say $gsi->apply->size;
}


### Implementation

# Create a generator for special numbers up to N in base B:
# Convert the sequence 1 .. N into base B and filter out non-special
# numbers.  A non-special number has a re-occurring digit.
# To count the number of special numbers we need to "apply" the
# generator and take its size.
sub gen_spec_int($n, $b) {
    <1..$n>->map(sub {todigitstring($_, $b)})->filter('!/(.).*\1/');
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_spec_int(15, 10)->apply->size, 14, 'Example 1';
        is gen_spec_int(35, 10)->apply->size, 32, 'Example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is gen_spec_int(9, 8)->apply->size, 8, '9 == 011';
        is gen_spec_int(18, 8)->apply->size, 16, '18 == 022';
        is gen_spec_int(37, 36)->apply->size, 36, 'base 36';
        is gen_spec_int(6**7, 6)->apply->size,
            gen_spec_int(6**6, 6)->apply->size,
            'no special numbers above B**B';

	}

    done_testing;
    exit;
}
