#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'uniqint';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

say strong_pairs(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/12/ch-277.html#task-2


sub strong_pairs {
    my @ints = uniqint sort {$a <=> $b} @_;
    my ($yi, $cnt) = (1, 0);
    for my $xi (0 .. $#ints) {
        my $x = $ints[$xi];
        $yi++ while $yi < @ints && $ints[$yi] < 2 * $x;
        $cnt += $yi - $xi - 1;
    }

    $cnt;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is strong_pairs(1, 2, 3, 4, 5), 4, 'example 1';
        is strong_pairs(5, 7, 1, 7), 1, 'example  2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is strong_pairs(map 2**$_,     0 .. 9), 0, 'no strong pairs';
        is strong_pairs(map 2**$_ + 1, 0 .. 9), 9, 'neighbors are strong pairs';
        is strong_pairs(10 .. 19),             45, 'all pairs are strong';

	}

    done_testing;
    exit;
}
