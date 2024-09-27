#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use PDL::Char;
use Graph::Undirected;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [ROW...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ROW...
    characters forming matrix rows, e.g.
        xxxxo xoooo xoooo xxxoo 
    for example 1

EOS


### Input and Output

say max_cont_block(PDL::Char->new(@ARGV)->dummy(0, 1));


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/27/ch-288.html#task-2


sub max_cont_block {
    state $r = indx [0, 0], [1, 0];
    state $c = indx [0, 0], [0, 1];

    my $m = PDL::Char->new(@_)->((0))->long;

    my $g = Graph::Undirected->new;
    $g->add_edge(map "$_", $_->dog) for
        (whichND($m(0:-2,) == $m(1:-1,))->dummy(1, 2) + $r)->dog,
        (whichND($m(,0:-2) == $m(,1:-1))->dummy(1, 2) + $c)->dog;

    max long map scalar @$_, $g->connected_components;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_cont_block([
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'o', 'o'],
                     ]), 11, 'example 1';
        is max_cont_block([
                       ['x', 'x', 'x', 'x', 'x'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                     ]), 11, 'example 2';
        is max_cont_block([
                       ['x', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                       ['o', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                     ]), 7, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is max_cont_block([
                       ['c', 'c', 'c', 'b', 'b'],
                       ['c', 'c', 'c', 'b', 'b'],
                       ['c', 'b', 'b', 'c', 'c'],
                       ['a', 'a', 'a', 'b', 'b'],
                     ]), 7, 'other chars';
    }

    done_testing;
    exit;
}
