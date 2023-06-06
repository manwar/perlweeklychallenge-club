#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Quantum::Superpositions;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [S...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

S...
    list of strings

EOS


### Input and Output

say "@{[common_chars(@ARGV)]}";


### Implementation

# Take each word as a disjunctive superposition of its lowercase letters
# and find the words' conjunctive superpositions.  Retrieve and sort the
# corresponding eigenstates, i.e. common characters.
sub common_chars {
    sort +eigenstates(all map any(split //, lc), @_);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [common_chars(qw(Perl Rust Raku))], ['r'], 'example 1';
        is [common_chars(qw(love live leave))], [qw(e l v)], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [common_chars(qw(abandon bizarre exorbitant harbor nebula))],
            [qw(a b)];
	}

    done_testing;
    exit;
}
