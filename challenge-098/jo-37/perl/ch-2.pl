#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';
use List::MoreUtils 0.423 'lower_bound';
use experimental 'signatures';

our ($tests, $examples, $verbose, $value);

run_tests() if $tests || $examples;    # does not return

die <<EOS unless defined $value;
usage: $0 [-examples] [-tests] [-verbose] [-value=num [--] n1 n2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show resulting index and array

-value=num
    number to insert or search for

n1 n2...
    sorted list of numbers

EOS

sub find_or_insert :prototype($\@);


### Input and Output

say scalar find_or_insert $value, @ARGV;


### Implementation

# Search for a value in the given sorted array insert it into the proper
# position if missing.
#
# Note 1: Has to be called with a true array as second argument.
# Note 2: Returns the index position when called in scalar context or a
#         reference to the resulting array together with the index
#         position in list context.
sub find_or_insert ($val, $arr) :prototype($\@) {

    # A binary search is the tool of choice to operate on sorted data.
    # "lower_bound" provides the wanted index accordingly.  Select zero
    # for an empty array.
    my $idx = @$arr ? lower_bound {$_ <=> $val} @$arr : 0;

    # Insert the value at the identified position if missing.  Use a
    # virtually appended 'inf' to force a "push" operation.
    splice @$arr, $idx, 0, $val if ($arr->[$idx] // 'inf') > $val;
    say "$idx: (@$arr)" if $verbose;

    # Return a reference to the resulting array and the index.
    ($arr, $idx);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip 'examples' unless $examples;

        my @a;

        @a = (1, 2, 3, 4);
        is find_or_insert(3, @a), 2, 'example 1';
        is [@a], [1, 2, 3, 4], 'resulting array for example 1';

        @a = (1, 3, 5, 7);
        is find_or_insert(6, @a), 3, 'example 2';
        is [@a], [1, 3, 5, 6, 7], 'resulting array for example 2';

        @a = (12, 14, 16, 18);
        is find_or_insert(10, @a), 0, 'example 3';
        is [@a], [10, 12, 14, 16, 18], 'resulting array for example 3';

        @a = (11, 13, 15, 17);
        is find_or_insert(19, @a), 4, 'example 4';
        is [@a], [11, 13, 15, 17, 19], 'resulting array for example 4';
    }

    SKIP: {
        skip 'tests' unless $tests;
 
        # Provide list context to retrieve the resulting array.

        is [find_or_insert 0, @{[]}], [[0], 0],
            'insert zero into empty list';

        is [find_or_insert 0, @{[0]}], [[0], 0],
            'find zero';

        is [find_or_insert -1, @{[0]}], [[-1, 0], 0],
            'insert negative value';
    }

    done_testing;
    exit;
}
