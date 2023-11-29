#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [lang,... popularity,...]

-examples
    run the examples from the challenge

-tests
    run some tests

-verbose
    enable trace output

lang,...
    list of (comma or blank) separated strings

popularity,...
    list of (comma or blank) separated numeric popularities

EOS


### Input and Output

say "(@{[sort_by_popularity(map [split /[ ,]/], @ARGV)]})";


### Implementation

sub sort_by_popularity ($lang, $p8y) {
	$lang->@[sort {$p8y->[$a] <=> $p8y->[$b]} 0 .. $p8y->$#*];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [sort_by_popularity(['perl', 'c', 'python'], [2, 1, 3])],
            ['c', 'perl', 'python'], 'example 1';

        is [sort_by_popularity(['c++', 'haskell', 'java'], [1, 3, 2])],
            ['c++', 'java', 'haskell'], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
