#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use autodie;
use Math::Prime::Util 'forperm';
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [ORIG PERM...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ORIG
    original string

PERM...
    list of strings to be checked for permutations of ORIG

EOS


### Input and Output

say for missing_perms(@ARGV);


### Implementation

# Loop over all permutations of the original string and collect results
# missing from the given list. 
# Generalizing the task to arbitrary strings that need not consist of
# unique letters and report unique missing permutations of the given
# string.

sub missing_perms ($orig, @given) {
    my @orig = split //, $orig;
    # Convert array to hash.
    (\my %given)->@{@given} = ();
    local $" = '';
    my %missing;
    # @_ holds the index set, not the values.
    forperm {
        $missing{"@orig[@_]"} = undef unless exists $given{"@orig[@_]"};
    } @orig;

    keys %missing;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [missing_perms('PERL', qw(PELR PREL PERL PRLE PLER
            PLRE EPRL EPLR ERPL ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE
            RLEP LPER LPRE LEPR LRPE LREP))], ['LERP'], 'task 1';

    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar(missing_perms('abcdef')), 720, '6!';
        is [missing_perms('aabb', 'aabb', 'bbaa')],
            bag {
                item 'abba';
                item 'baab';
                item 'abab';
                item 'baba';
                end;
            }, 'non-unique letters';
	}

    done_testing;
    exit;
}
