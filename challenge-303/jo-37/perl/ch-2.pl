#!/usr/bin/perl -s

use v5.25;
use Test2::V0;
use List::MoreUtils 'frequency';
use POSIX 'Inf';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say delete_and_earn(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/10/ch-303.html#task-2


sub delete_and_earn {
    my %vals = frequency @_;
    my $points;
    outer:
    while (%vals) {
        my $ml = Inf;
        my $sel;
        for my $i (keys %vals) {
            my $l = ($i - 1) * ($vals{$i - 1} // 0) +
                ($i + 1) * ($vals{$i + 1} // 0);
            ($sel, $ml) = ($i, $l) if $l < $ml;
        }
        $points += $sel * $vals{$sel};
        delete @vals{$sel - 1, $sel, $sel + 1};
    }
    $points;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is delete_and_earn(3, 4, 2), 6, 'example 1';
        is delete_and_earn(2, 2, 3, 3, 3, 4), 9, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is delete_and_earn(2, 2, 3, 3, 3, 4, 4), 12, 'minimize loss';
        is delete_and_earn(-1, -1, 0, 1), 0, 'negative loss';
        is delete_and_earn(-1, 0, 1, 1), 1, 'reversed';

    }

    done_testing;
    exit;
}
