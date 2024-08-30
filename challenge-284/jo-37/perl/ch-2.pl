#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [N1,N2,... M1,M2,...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1,N2,...
    numbers in \@list1, comma and/or space separated

M1,M2,...
    numbers in \@list2, comma and/or space separated

EOS


### Input and Output

say "(@{relative_sort(map [split /[, ] */, $_], @ARGV)})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/30/ch-284.html#task-2

sub relative_sort ($list1, $list2) {
    (\my %list2)->@{@$list2} = ();
    my @part2;
    for my $n (@$list1) {
        if (exists $list2{$n}) {
            $list2{$n}++;
        } else {
            push @part2, $n;
        }
    }

    [
        (map +($_) x $list2{$_}, @$list2),
        (sort {$a <=> $b} @part2),
    ];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is relative_sort( [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
                [2, 1, 4, 3, 5, 6]),
                [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9],
                'example 1';
        is relative_sort( [3, 3, 4, 6, 2, 4, 2, 1, 3],
                [1, 3, 2]),
                [1, 3, 3, 3, 2, 2, 4, 4, 6],
                'example 2';
        is relative_sort( [3, 0, 5, 0, 2, 1, 4, 1, 1],
                [1, 0, 3, 2]),
                [1, 1, 1, 0, 0, 3, 2, 4, 5],
                'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is relative_sort( [-20, 0, 1, 2],
                [2, 1]),
                [2, 1, -20, 0],
                'negative';
    }


    done_testing;
    exit;
}
