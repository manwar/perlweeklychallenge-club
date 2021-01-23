#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;    # does not return

say(<<EOS), exit unless @ARGV == 2;
usage: $0 [-tests] [-examples] [-verbose] [--] [source target]

-tests
    run some tests

-examples
    run the examples from the challenge
 
-verbose
    display edit operations and internal distance matrix

source target
   calculate levenshtein distance between source and target words

EOS


### Input and Output

say levenshtein_distance($ARGV[0], $ARGV[1]);


### Implementation


sub cost;
sub min_ind;

# Calculate the Levenshtein distance between two words, i.e. the minimum
# number of insert, delete or replace actions to transform the first
# word into the second.  PDL implementation of the Wagner-Fischer
# algorithm, see https://en.wikipedia.org/wiki/Wagner-Fischer_algorithm
sub levenshtein_distance ($source, $target) {

    # Split words into arrays and (un)shift by one to match matrix
    # dimensions.
    my @source = (undef, split //, $source);
    my @target = (undef, split //, $target);

    # Prepare distance matrix holding BAD values only.
    my $dist = zeros(long, @source + 0, @target + 0)->setvaltobad(0);

    # Fill first row and column with ascending sequences as the costs of
    # removing or inserting a prefix of that length.
    $dist->slice(',(0)') .= sequence $dist->dim(0);
    $dist->slice('(0),') .= sequence $dist->dim(1);

    # To fill the remaining fields, loop over the indices of all BAD
    # values.  With the index order provided by "whichND" the required
    # "flood filling" is achieved.
    for my $idx ($dist->isbad->whichND->dog) {

        # Character pair for index position.
        my $cs = $source[$idx->at(0)];
        my $ct = $target[$idx->at(1)];

        # 2x2 neighborhood matrix preceeding index.
        my $nb = $dist->range($idx - 1, 2);

        # 2x2 transition cost matrix.
        my $trans = cost $cs ne $ct;

        # The cost to reach the new field is the minimum of the sums of
        # the previous cost and the transition cost.
        $dist->indexND($idx) .= min $nb + $trans;
    }

    explain_edit(\@source, \@target, $dist) if $verbose;

    # The requested Levenshtein distance is the bottom right matrix
    # element.
    $dist->indexND($dist->shape - 1);
}

# Backtrack the steps that led to the lower right corner of the distance
# matrix and describe the corresponding edit operations.
sub explain_edit ($source, $target, $dist) {

    # Collect edit operations.
    my @edit;

    # Start at bottom right corner.
    my $idx = $dist->shape - 1;

    # Stop at upper left corner.
    while (any $idx) {

        # Character pair for index position.
        my $cs = $source->[$idx->at(0)];
        my $ct = $target->[$idx->at(1)];

        # 2x2 neighborhood matrix preceeding index, truncated to BAD
        # values across the matrix' borders.
        my $nb = $dist->range($idx - 1, 2, 'truncate');

        # The field preceeding the current field holds the minimum
        # within the neighborhood.  Find the minimum and the
        # corresponding index.  On a non-unique minimum, this will
        # prefer the diagonal "replace" move.
        my ($min, $pred) = min_ind $nb;

        # Record the edit operation.
        unshift @edit,
            any($pred) ?
                $pred->at(0) ?
                    "ins($ct)" :
                    "del($cs)" :
                $dist->indexND($idx) == $min ?
                    "keep($cs)" :
                    "repl($cs,$ct)";

        # Move to predecessor field.
        $idx = $idx - 1 + $pred;
    }

    {
        no warnings 'uninitialized';
        say @$source, ' -> ', @$target, ':';
    }
    say "@edit";
    say "Levenshtein distance = ", $dist->indexND($dist->shape - 1);
    say "Wagner-Fischer distance matrix:", $dist;
}

# Cost matrix for a single insert, delete and keep/replace.
sub cost ($repl) {
    long([0, 1], [1, 0])->setvaltobad(0)->set(0, 0, $repl);
}

# Find the minimum in an N-dim piddle together with the corresponding
# index.
sub min_ind ($pdl) {
	my $min = min $pdl;
	my $index = whichND($pdl == $min)->slice(',(0)');

    ($min, $index);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is levenshtein_distance('kitten', 'sitting'), 3, 'example 1';
        is levenshtein_distance('sunday', 'monday'), 2, 'example 2';
        is levenshtein_distance('Saturday', 'Sunday'), 3,
            'example from wikipedia';
        is levenshtein_distance('parachute', 'headache'), 5,
            'another example';
    }

    SKIP: {
        skip "tests" unless $tests;
        is levenshtein_distance('abcdef', 'uvwxyz'), 6, 'replace all';
        is levenshtein_distance('def', 'abcdef'), 3, 'insert prefix';
        is levenshtein_distance('abcdef', 'def'), 3, 'delete prefix';
        is levenshtein_distance('abcdef', 'uvwdef'), 3, 'replace prefix';
        is levenshtein_distance('abc', 'abcdef'), 3, 'insert suffix';
        is levenshtein_distance('abcdef', 'abc'), 3, 'delete suffix';
        is levenshtein_distance('abcdef', 'abcxyz'), 3, 'replace suffix';
        is levenshtein_distance('abef', 'abcdef'), 2, 'insert infix';
        is levenshtein_distance('abcdef', 'abef'), 2, 'delete infix';
        is levenshtein_distance('abcdef', 'abwxef'), 2, 'replace infix';
    }
    done_testing;
    exit;
}
