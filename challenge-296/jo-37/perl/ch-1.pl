#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $verbose, $decode);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-decode] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

-decode
    run length decode the given string. Default: encode

STR
    a string to be run length en/de-coded

EOS


### Input and Output

say $decode ? rld(shift) : rle(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/22/ch-296.html#task-1


sub rle {
    shift =~ s/(([[:alpha:]])\2+)/length($1) . $2/ger;
}

sub rld {
    shift =~ s/([[:digit:]]+)([[:alpha:]])/$2 x $1/ger;
}

### Examples and tests

sub test {
    my ($dec, $enc, $desc) = @_;
    is rle($dec), $enc, "encode $desc";
    is rld($enc), $dec, "decode $desc";
}

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        test("abbc", "a2bc", "example 1");
        test("aaabccc", "3ab3c", "example 2");
        test("abcc", "ab2c", "example 3");
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
