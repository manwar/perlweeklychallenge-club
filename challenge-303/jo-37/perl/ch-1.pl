#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::UtilsBy 'uniq_by';
use List::Gather;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [D...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

D...
    list of decimal digits

EOS


### Input and Output

say "(@{three_digit_even(@ARGV)})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/10/ch-303.html#task-1


sub three_digit_even {
    my @all = map [$_, 1], map split(//), @_;
    my @head = grep $_->[0], @all;
    my @tail = grep !($_->[0] % 2), @all;
    return [] unless @all >= 3 && @head && @tail;

    [sort {$a <=> $b} gather {
        for my $d2 (uniq_by {$_->[0]} @tail) {
            local $d2->[1];
            for my $d0 (uniq_by {$_->[0]} grep $_->[1], @head) {
                local $d0->[1];
                for my $d1 (uniq_by {$_->[0]} grep $_->[1], @all) {
                    take $d0->[0].$d1->[0].$d2->[0];
                }
            }
        }
    }];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is three_digit_even(2, 1, 3, 0),
            [102, 120, 130, 132, 210, 230, 302, 310, 312, 320], 'example 1';
        is three_digit_even(2, 2, 8, 8, 2),
            [222, 228, 282, 288, 822, 828, 882], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is three_digit_even(0, 0, 1, 3), [100, 130, 300, 310], 'zero as even';
        is scalar @{three_digit_even(0, 0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5,
            6, 6, 6, 7, 7, 8, 8, 8, 9, 9)}, 450, '100 .. 998';
        is three_digit_even(0, 0, 2), [200], 'single nonzero';
        is three_digit_even(1, 2), [], 'two digits';
        is three_digit_even(1, 1, 1), [], 'no even';
        is three_digit_even(0, 0, 0), [], 'zero only';
        is three_digit_even(101), [110], 'multi-digit';
    }

    done_testing;
    exit;
}
