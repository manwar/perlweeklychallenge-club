#!/usr/bin/perl -s

use v5.26;
use Test2::V0;

our ($tests, $examples, $verbose, $broken);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless $broken =~ /\w+/ && @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-broken=BROKEN] [WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print typeable words instead of counting them

-broken=BROKEN
    string of broken keys

WORD...
    list of words

EOS


### Input and Output

main: {
    my @typeable = broken_keys([split //, $broken], "@ARGV");
    say $verbose ? "@typeable" : scalar @typeable;
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/28/ch-275.html#task-1


sub broken_keys {
    my $typeable = qr{^[^@{+shift}]+$}ixx;

    grep /$typeable/, split /\s+/, shift;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar broken_keys(['l', 'a'], 'Perl Weekly Challenge'), 0, 'example 1';
        is scalar broken_keys(['a'], 'Perl and Raku'), 1, 'example 2';
        is scalar broken_keys(['l', 'o'], 'Well done Team PWC'), 2, 'example 3';
        is scalar broken_keys(['T'], 'The joys of polyglottism'), 2, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
