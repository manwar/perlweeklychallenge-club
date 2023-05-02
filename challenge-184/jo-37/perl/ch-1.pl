#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STRING...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STRING
    list of strings

EOS


### Input and Output

say "(@{[sequence_number(@ARGV)]})";


### Implementation

# It is not clear how to maintain prefixes that come out of order.  In
# the examples the prefixes are simply replaced with a two-digit number.
sub sequence_number {
	my $seq = 0;
    map s/^[a-z]{2}(?=\d+$)/sprintf "%02d", $seq++/er, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [sequence_number('ab1234', 'cd5678', 'ef1342')],
            ['001234', '015678', '021342'], 'example 1';

        is [sequence_number('pq1122', 'rs3334')],
            ['001122', '013334'], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [sequence_number('112233')], ['112233'], 'no prefix';
        is [sequence_number('abc123')], ['abc123'], 'prefix too long';
        is [sequence_number('ab')], ['ab'], 'no suffix';

	}

    done_testing;
    exit;
}
