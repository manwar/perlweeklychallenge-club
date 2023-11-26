#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $verbose, $allowed);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless $allowed && @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-allowed=A STR...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print consistent strings instead of counting them

-allowed=A
    string of allowed characters

STR...
    list of strings

EOS


### Input and Output

say $verbose ?
    "@{[count_consistent($allowed, @ARGV)]}" :
    scalar count_consistent($allowed, @ARGV);


### Implementation

sub count_consistent {
    # there is no restriction to a character class in the task.  So
    # allow meta characters, too:
    my $allowed = quotemeta shift;
    grep /^[$allowed]*$/, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar count_consistent(ab =>
            qw(ad bd aaab baa badab)), 2, 'example 1';

        is scalar count_consistent(abc =>
            qw(a b c ab ac bc abc)), 7, 'example 2';

        is scalar count_consistent(cad =>
            qw(cc acd b ba bac bad ac d)), 4, 'example 3';

    }

    SKIP: {
        skip "tests" unless $tests;

        is [count_consistent('a-z].*[0-9' =>
            qw(bc+1 .]0a a*z b-y))], [qw(.]0a a*z)], 'meta chars';

        is count_consistent(abc => ''), 1, 'allow empty';
	}

    done_testing;
    exit;
}
