#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Unicode::Normalize 'NFD';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR ...
    Strings to be made over

EOS

binmode STDOUT, ':utf8';


### Input and Output

say for map makeover($_), @ARGV;


### Implementation

# Decompose the input string, split it into grapheme clusters and
# take the first character of each cluster as the base character.
# Note:
# - This procedure removes all diacritic marks from a base character.
# - For non-ASCII base characters the result is still non-ASCII (see
#   "tests").

sub makeover {
    join '', map substr($_, 0, 1), NFD(shift) =~ /\X/g;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is makeover('ÃÊÍÒÙ'), 'AEIOU', 'example 1';
        is makeover('âÊíÒÙ'), 'aEiOU', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is makeover(
            "\N{LATIN CAPITAL LETTER A WITH RING ABOVE AND ACUTE}" .
            "\N{LATIN CAPITAL LETTER A}\N{COMBINING ACUTE ACCENT}\N{COMBINING RING ABOVE}" .
            "\N{LATIN CAPITAL LETTER A}" . 
            "\N{GREEK CAPITAL LETTER OMEGA WITH VARIA}"),
        'AAAΩ',
        'composed, decomposed, unmodified and non-ascii chars';
	}

    done_testing;
    exit;
}
