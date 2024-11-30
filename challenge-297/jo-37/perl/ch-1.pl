#!/usr/bin/perl -s

use v5.12;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [B...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

B...
    list of binary digits

EOS


### Input and Output

say max_contig(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/29/ch-297.html#task-1

sub max_contig {
    my %firstlast = (0 => [0]);
    my ($max, $s, $i) = 0;
    for my $b (@_) {
        $s += $b || -1;
        $i++;
        my $fl = $firstlast{$s} //= [$i];
        $fl->[1] = $i;
        my $len = $fl->[1] - $fl->[0];
        $max = $len if $len > $max;
    }
    $max;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_contig(1, 0),             2, 'example 1';
        is max_contig(0, 1, 0),          2, 'example 2';
        is max_contig(0, 0, 0, 0, 0),    0, 'example 3';
        is max_contig(0, 1, 0, 0, 1, 0), 4, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is max_contig(1, 1, 0, 0, 0, 0, 1, 0), 4,     'head';
        is max_contig(0, 1, 0, 0, 0, 0, 1, 1), 4,     'tail';
        is max_contig((0, 1, 1, 1) x 1000),    2,     'no more than 2';
        is max_contig((0, 1) x 2000),          4000,  'small teeth';
        is max_contig((0) x 2000, (1) x 2000), 4000,  'big tooth';
        is max_contig((0, 1) x 1000, 1, (1, 0) x 1000), 2000, 'middle one';
    }

    done_testing;
    exit;
}
