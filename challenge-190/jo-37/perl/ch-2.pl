#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [CODE]

-examples
    run the examples from the challenge
 
-tests
    run some tests

CODE
    code sequence

EOS


### Input and Output

say for decode(shift);


### Implementation

# We have an encoding from letters starting with A, B, C, D to codes 1,
# 2, 3, 4.  The end of the sequence is not specified by the task's
# description, but from example 3 it becomes clear that the sequence
# ends with Z.  Otherwise there would be a decoding for 27.
#
# A valid encoding thus must be matched by
#   /^(?:[1-9]|1[0-9]|2[0-6])+$/
# Capturing and recording the internal matches and forcing the regex
# engine into backtracking reveals all possible partitions of the
# encoding.

sub decode {
    my @part;
    our @p;

    # Split the encoding into all possible partitions:
    shift =~ m{
        ^
        (?| ([1-9])  (?&REC)    # Process a matching branch, see below.
          | (1[0-9]) (?&REC)
          | (2[0-6]) (?&REC)
        )+
        $
        (?{push @part, [@p]})   # Persist a complete partition.
        (*FAIL)                 # Force backtracking.

        (?(DEFINE)              # Define
            (?<REC>             # a capture group named "REC" as:
                (?{local @p = @p; push @p, $1})
                                # Create a backtracking-safe copy of the
                                # current (incomplete) partition and
                                # record the previously captured part of
                                # the string.
            )
        )
    }x;

    # Loop over the found partitions and convert the codes into their
    # corresponding encoded ASCII characters.
    map {pack 'C*', map ord('A') + $_ - 1, @$_} @part;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [decode(11)],   [qw(AA K)],                'Example 1';
        is [decode(1115)], [qw(AAAE AAO AKE KAE KO)], 'Example 2';
        is [decode(127)],  [qw(ABG LG)],              'Example 3';

    }

    SKIP: {
        skip "tests" unless $tests;

        is  decode(130),      F(),         'invalid zero';
        is [decode(120)],     ['AT'],      'valid zero';
        is [decode(3 x 128)], ['C' x 128], 'long code';
	}

    done_testing;
    exit;
}
