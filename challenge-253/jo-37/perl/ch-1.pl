#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $sep);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless defined $sep && @ARGV;
usage: $0 [-examples] [-tests] [-sep=S STR...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-sep=C
    use C as separator

STR
    list of strings

EOS


### Input and Output

say join ',', map qq("$_"), split_strings($sep, @ARGV);


### Implementation

sub split_strings {
    my $sep = shift;
	grep length, map +(split /\Q$sep/), @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [split_strings('.' => "one.two.three","four.five","six")],
            ["one","two","three","four","five","six"], 'example 1';
        is [split_strings('$' => '$perl$$', '$$raku')],
            ["perl","raku"], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [split_strings(0 => qw(00aa00b00 00c00dd00))],
            [qw(aa b c dd)], 'empty fields with zero separator';
	}

    done_testing;
    exit;
}
