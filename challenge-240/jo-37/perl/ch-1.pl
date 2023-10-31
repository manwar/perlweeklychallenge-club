#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $acronym);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless $acronym && @ARGV;
usage: $0 [-examples] [-tests] [-acronym=A WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-acronym=A
    check words against acronym A

WORD...
    list of words

EOS


### Input and Output

say is_acronym($acronym, @ARGV) ? 'true' : 'false';


### Implementation

# Pick the first character of each word, convert these to lower case and
# compare the joined result to the lower case given acronym.
sub is_acronym {
    # Need two "map"s here because "lc" forces scalar context and the
    # regex match needs to be in list context.
    lc(shift) eq join '', map lc, map /(.)/, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  is_acronym("ppp" => "Perl", "Python", "Pascal"), 'example 1';
        ok !is_acronym("rp" => "Perl", "Raku"), 'example 2';
        ok  is_acronym("oac" => "Oracle", "Awk", "C"), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok is_acronym("äöü" => "Ärger", "Öde", "Übel"), 'umlaute';
	}

    done_testing;
    exit;
}
