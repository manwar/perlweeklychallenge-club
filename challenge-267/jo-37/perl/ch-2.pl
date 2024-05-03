#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $limit, $widths);
$limit //= 100;
my @widths = split /[,\s]\s*/, $widths;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && @widths == 26;
usage: $0 [-examples] [-tests] [-limit=L] [-widths=W1,...,W26] STR

-examples
    run the examples from the challenge
 
-tests
    run some tests

-limit=L
    maximum line length. Default: 100

-widths=W1,...,W26
    character widths

STR
    a string

EOS


### Input and Output

printf "(%d, %d)\n", line_counts(shift, \@widths, $limit);



### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/03/ch-267.html#task-2


sub line_counts ($str, $widths, $limit) {
	my ($lines, $width) = (0, 0);
    state $letters;
    $letters->@{'a' .. 'z'} = (0 .. 25) unless $letters;
    for my $c ($str =~ /[a-z]/g) {
        my $len = $widths->[$letters->{$c}];
        if ($width + $len > $limit) {
            $width = 0;
        }
        $lines++ unless $width;
        $width += $len;
    }

    ($lines, $width);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [line_counts("abcdefghijklmnopqrstuvwxyz",
                [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
                    10,10,10,10,10,10,10,10], 100)], [3, 60], 'example 1';

        is [line_counts("bbbcccdddaaa",
                [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
                    10,10,10,10,10,10,10,10], 100)], [2, 4], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [line_counts("a" x 10, [(10) x 26], 100)], [1, 100], 'full line';

        is [line_counts(("b" x 10) . ("a" x 10), [0, (10) x 25], 100)],
            [1, 100], 'zero length';

        is [line_counts("", [(1) x 26], 100)],
            [0, 0], 'empty string';
	}

    done_testing;
    exit;
}
