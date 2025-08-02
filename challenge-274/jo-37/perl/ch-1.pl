#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [SENTENCE]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SENTENCE
    a sentence

EOS


### Input and Output

say qq{@{[goat_latin("@ARGV")]}};


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/19/ch-274.html#task-1


sub goat_latin {
    my $na = 1;
    no warnings 'uninitialized';
    shift =~ s#\s*\K(?i:([^aeiou])?)(\w+)#"$2$1m" . ("a" x ++$na)#ger
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is goat_latin("I love Perl"), "Imaa ovelmaaa erlPmaaaa", "example 1";
        is goat_latin("Perl and Raku are friends"),
            "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa", "example 2";
        is goat_latin("The Weekly Challenge"), "heTmaa eeklyWmaaa hallengeCmaaaa",
            "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
