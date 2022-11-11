#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    String to check for appropriate capital usage

EOS


### Input and Output

say 0 + !!check_caps(shift);


### Implementation

# There is no need to restrict this task to ASCII letters.  For Unicode
# characters there are properties "Letter uppercase" and "Letter
# lowercase".  Using these here.
sub check_caps {
	shift =~ /^\p{Lu}?(?:\p{Lu}*|\p{Ll}*)$/;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  check_caps('Perl'),   'Example 1';
        ok  check_caps('TPF'),    'Example 2';
        ok !check_caps('PyThon'), 'Example 3';
        ok  check_caps('raku'),   'Example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok  check_caps('Περλ'),   'Example 1 greek';
        ok  check_caps('ΤΠΦ'),    'Example 2 greek';
        ok !check_caps('ΠυΘων'),  'Example 3 greek';
        ok  check_caps('ρακου'),  'Example 4 greek';
        ok  check_caps('Π'),      'single uppercase';
        ok  check_caps('ρ'),      'single lowercase';
        ok !check_caps('1etter'), 'not a letter';

	}

    done_testing;
    exit;
}
