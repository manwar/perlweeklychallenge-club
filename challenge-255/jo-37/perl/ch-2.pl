#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::UtilsBy 'max_by';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [P W...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

P
    a paragraph

W...
    list of banned words

EOS


### Input and Output

say mfw(@ARGV);


### Implementation

sub mfw  {
    my $p = shift;
    my %count;
    $count{$_}++ for split /\W+/, $p;
    delete @count{@_}; 
    max_by {$count{$_}} keys %count;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is mfw('Joe hit a ball, the hit ball flew far after it was hit.',
            'hit'), 'ball', 'example 1';
        is mfw('Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.',
            'the'), 'Perl', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is mfw('one two three four five two three four five three four five four five five', 'two', 'four', 'five'), 'three', 'more banned words';
	}

    done_testing;
    exit;
}
