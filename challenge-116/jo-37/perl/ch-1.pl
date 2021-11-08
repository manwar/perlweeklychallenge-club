#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [num]

-examples
    run the examples from the challenge
 
-tests
    run some tests

num
   Number to be split into a successing sequence

EOS


### Input and Output

say join ',', @{succ_seq(shift)};


### Implementation

# Splitting any kind of sequence into smaller subsequences preserves
# their original order.  Assuming this interpretation in accordance with
# the examples.
# Furthermore, the difference between two consecutive parts shall always
# be one, or in other words: each part (except the first) shall be the
# successor of the previous.  As leading zeros are not allowed for a
# part, every subsequent part is thus uniquely determined by its
# predecessor.
# Given that Perl's auto-increment operator acts on strings too,
# excessively large numbers may be processed as long as they are
# provided as strings.  See test cases.

sub succ_seq {
    local $_ = shift;
    # As the input is taken as a string, leading zeros must be excluded,
    # since    ++($_ = '01') eq '02'   is true.  Luckily this is a
    # prerequisite in the task.
    die "not valid\n" unless /^[1-9][0-9]+\z/;

    # Try first parts that have half of the string's length at most.
    for my $len (1 .. length() / 2) {
        # Accept any first part having the current length.
        my $part = qr/.{$len}/;

        my @split;
        while (/\G($part)/g) {
            # Collect the matched part and take its successor as the
            # next expected match.
            push @split, ($part = $1)++;
            # If the current match extends to the end of the string, the
            # collected parts represent a solution.
            return \@split if pos() == length();
        }
    }

    # Default:
    [$_];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is succ_seq(1234), [1, 2, 3, 4], 'example 1';
        is succ_seq(91011), [9, 10, 11], 'example 2';
        is succ_seq(10203), [10203], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is succ_seq(9899100101), [98, 99, 100, 101], 'split around 100';
        is succ_seq(999910000), [9999, 10000], 'split around 10000';
        is succ_seq(1819202), [1819202], 'missing last digit';
        is succ_seq(109), [109], 'out of sequence';
        is succ_seq(1012), [1012], 'step too high';
        like dies {succ_seq('0102')}, qr/not valid/,
            'would falsely work on strings';

        my @expected = ('9' x 99, '1' . '0' x 99);
        is succ_seq(join '', @expected), \@expected, '199 digits in 2 parts';

        @expected = 3 .. 103;
        is succ_seq(join '', @expected), \@expected, '199 digits in 101 parts';
	}

    done_testing;
    exit;
}
