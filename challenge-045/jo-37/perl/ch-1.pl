#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::Char;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [PLAIN]

-examples
    run the examples from the challenge
 
-tests
    run some tests

PLAIN
    plaintext to be square secret encoded

EOS


### Input and Output

say "@{square_secret(shift)}";


### Implementation

sub square_secret ($s) {
    # Transform to lowercase and remove blanks.
    my $plain = PDL::Char->new($s =~ tr/A-Z /a-z/dr);
    # Split the string into single characters and rearrange them to a
    # 8xN matrix, transpose and join the rows to strings. Then return
    # each string individually.
    [map $_->atstr(0),
        $plain->reshape(1, 8, ceil $plain->dim(0) / 8)
        ->xchg(1, 2)->clump(0, 1)->dog];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is square_secret('The quick brown fox jumps over the lazy dog'),
        [qw(tbjrd hruto eomhg qwpe unsl ifoa covz kxey)], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
