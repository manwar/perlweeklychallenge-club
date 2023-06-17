#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::MoreUtils qw(frequency reduce_0 all);

our ($tests, $examples, $chars);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && $chars;
usage: $0 [-examples] [-tests] [-verbose] [--] [-chars=CHARS WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-chars=CHARS
    specify the characters that define "good strings"

WORD...
    list of words

EOS


### Input and Output

say good_string_length($chars, @ARGV);


### Implementation

# For every given word, check if it can be formed from the given
# characters and cumulate the lengths of all "good strings".
sub good_string_length {
    my %chars = frequency split //, shift;

    reduce_0 {
        my %count = %chars;
        $count{$_}-- for split //, $b;
        $a + length($b) * all {$_ >= 0} values %count;
    } @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is good_string_length(qw(atach cat bt hat tree)), 6, 'example 1';
        is good_string_length(qw(welldonehopper hello world challenge)),
           10, 'example 2' 
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
