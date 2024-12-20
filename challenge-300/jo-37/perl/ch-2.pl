#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [P...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

P...
    zero based permutation

EOS


### Input and Output

say nested(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/12/20/ch-300.html#task-2


sub nested {
    my $l = long @_;
    my $pn = identity($l);
    my $m = $pn->copy;
    my $p = $pn($l)->sever;;
    my $c;
    $c++, $m += ($pn = $pn x $p) while 2 > min $m->maxover;

    $c;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is nested(5, 4, 0, 3, 1, 6, 2), 4, 'example 1';
        is nested(0, 1, 2), 1, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is nested(1, 2, 3, 0, 5, 6, 4), 4, 'type 4,3';
        is nested(1, 2, 3, 4, 5, 6, 0), 7, 'type 7';
    }

    done_testing;
    exit;
}
