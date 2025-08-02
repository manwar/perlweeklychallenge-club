#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use Benchmark 'cmpthese';

our ($tests, $examples, $benchmark);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say stc(@ARGV);


### Implementation

sub stc {
    my $l = long @_;
    my $si = $l->qsorti;
    cat($si, sequence($l) - $l->($si)->dummy(0)->enumvec)
        ->xchg(0,1)->qsortvec->((1));
}

sub stc_full {
    my $l = long @_;
    ($l < $l->dummy(0))->sumover;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is stc(5, 2, 1, 6)->unpdl, [2, 1, 0, 3], 'example 1';
        is stc(1, 2, 0, 3)->unpdl, [1, 2, 0, 3], 'example 2';
        is stc(0, 1)->unpdl, [0, 1], 'example 3';
        is stc(9, 4, 9, 2)->unpdl, [2, 1, 2, 0], 'example 4';

    }

    SKIP: {
        skip "tests" unless $tests;
    }

    SKIP: {
        skip "benchmark" unless $benchmark;

        my $n = 10000;
        my $l = ($n * random $n)->long;
        ok all(stc_full($l) == stc($l)), 'cross-check';

        cmpthese(0, {
                full => sub {stc_full($l)},
                rank => sub {stc($l)}
            });

    }

    done_testing;
    exit;
}
