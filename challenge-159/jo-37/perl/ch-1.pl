#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Syntax::Keyword::Gather;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print the Farey sequence for N

EOS


### Input and Output

say for farey_sequence(shift);


### Implementation

# Adopted from the Wikipedia article.
sub farey_sequence ($k) {

    gather {
        my ($n_p, $d_p, $n, $d) = (0, 1, 1, $k);
        take "$n_p/$d_p";
        take "$n/$d";
        while ($d > 1) {
            # Calculate the new numerator and denominator from the
            # previous values. 
            my $f = int +($d_p + $k) / $d;
            ($n_p, $d_p, $n, $d) = ($n, $d, $f * $n - $n_p, $f * $d - $d_p);
            take "$n/$d";
        }
    };
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar(farey_sequence(5)),
            [qw(0/1 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1)],
            'example 1';

        is scalar(farey_sequence(7)),
            [qw(0/1 1/7 1/6 1/5 1/4 2/7 1/3 2/5 3/7 1/2 4/7 3/5 2/3 5/7
                3/4 4/5 5/6 6/7 1/1)],
            'example 2';

        is scalar(farey_sequence(4)),
            [qw(0/1 1/4 1/3 1/2 2/3 3/4 1/1)],
            'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar(farey_sequence(8)),
            [qw(0/1 1/8 1/7 1/6 1/5 1/4 2/7 1/3 3/8 2/5 3/7 1/2 4/7 3/5
                5/8 2/3 5/7 3/4 4/5 5/6 6/7 7/8 1/1)],
            'From Wikipedia';
	}

    done_testing;
    exit;
}
