#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::Opt::GLPK;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [-verbose]  [TARGET STICKER...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show the required stickers instead of their count and print
    the underlying linear program to "ch-2.lp" in CPLEX LP format

TARGET
    the word to be build from the given stickers

STICKER
    a list of stickers

EOS


### Input and Output

main: {
    my ($selection, $count) = min_stickers(@ARGV);
    if ($verbose) {
        say "@$selection";
    } else {
        say $count;
    }
}


### Implementation

sub min_stickers {
    my $target = long map ord, split //, shift;
    my $stickers = long map [map ord, split //, $_], @_;

    my ($b, $required) = $target->qsort->rle;
    my $a = ($required->dummy(0)->dummy(0) == $stickers)->sumover;
    my $c = ones($a->dim(1));

    my $xopt = null;
    my $fopt = null;
    my $status = null;

    eval {
        glpk($c, $a, $b, zeros($c), inf($c),
            GLP_LO * ones($b), GLP_IV * ones($c), GLP_MIN,
            $xopt, $fopt, $status,
            {save_pb => $verbose, save_fn => 'ch-2.lp'});
        1;
    } || return ([], 0);

    ([map +($_[$_]) x $xopt->at($_), 0 .. $#_], $fopt);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar(min_stickers('peon' => 'perl','raku','python')), 2,
            'example 1';
        is scalar(min_stickers('goat' => 'love','hate','angry')), 3,
            'example 2';
        is scalar(min_stickers('accomodation' => 'come','nation','delta')), 4,
            'example 3';
        is scalar(min_stickers('accomodation' => 'come','country','delta')), 0,
            'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar(min_stickers('feo' => 'fee', 'foo')), 2, 'integer solution';
	}

    done_testing;
    exit;
}
