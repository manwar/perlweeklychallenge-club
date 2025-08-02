#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'reduce';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of items

EOS


### Input and Output

say max_freq(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/05/ch-276.html#task-2


sub max_freq {
    my ($maxfreq, %freq) = 0;

    reduce {
        &{ ( sub {$a + $maxfreq},
             sub {$maxfreq = $freq{$b}},
             sub {$a}
           )[++$freq{$b} <=> $maxfreq]
        }()
    } 0, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_freq(1, 2, 2, 4, 1, 5), 4, 'example 1';
        is max_freq(1, 2, 3, 4, 5), 5, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is max_freq(qw(a b a b c d c d e f e f e c a)), 9, 'non-numbers'
	}

    done_testing;
    exit;
}
