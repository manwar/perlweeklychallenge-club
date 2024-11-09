#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

say middle_index(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-291.html#task-1


sub middle_index {
    my $i = long @_;
    my $mi = which $i->cumusumover == $i(-1:0)->cumusumover->(-1:0);

    $mi->isempty ? -1 : $mi((0));
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is middle_index(2, 3, -1, 8, 4), 3, 'example 1';
        is middle_index(1, -1, 4), 2, 'example 2';
        is middle_index(2, 5), -1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is middle_index(1, -1, 1), 0, 'implicit left zero';
        is middle_index(-4, 4, 2), 2, 'implicit right zero';
    }

    done_testing;
    exit;
}
