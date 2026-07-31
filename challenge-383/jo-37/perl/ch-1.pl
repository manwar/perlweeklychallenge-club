#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Set::Scalar;
use List::Util 'zip';
use List::MoreUtils qw(all any);


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - similar lists

    usage: $0 [-examples] [-tests] [LIST... SIMILARITIES]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    LIST...
        lists of comma separated words

    SIMILARITIES
        list of semicolon separated lists of comma separated
        lists of similar words

    EOS
}


### Input and Output

main: {
    my @similarities = map [split /,/],  split /;/, pop;
    my @lists = map [split /,/, $_], @ARGV;
    say +(qw(true false))[!similar_lists(@lists, \@similarities)];
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/07/24/ch-383.html#task-1

sub similar_lists {
    my @similar = map Set::Scalar->new(@$_), pop()->@*;

    all {
        my $col = Set::Scalar->new(@$_);
        $col->size == 1 || any {$col <= $_} @similar;
    } zip @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = similar_lists(@$args);
        is $result, $expected,
            qq{$name: @{[map "(@$_)", $args->@[0..$#$args - 1]]} (@{[map "[@{[@$_]}]", $args->[-1]->@*]}) -> } . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[["great", "acting"], ["fine", "drama"],
                    [["great", "fine"], ["acting", "drama"]]], T(),
                'example 1'],
            [[["apple", "pie"], ["banana", "pie"],
                    [["apple", "peach"], ["peach", "banana"]]], F(),
                'example 2'],
            [[["perl4", "python"], ["raku", "python"],
                    [["perl4", "perl5", "raku"]]], T(),
                'example 3'],
            [[["enjoy", "challenge"], ["love", "weekly", "challenge"],
                    [["enjoy", "love"]]], F(),
                'example 4'],
            [[["fast", "car"], ["quick", "vehicle"],
                    [["quick", "fast"], ["vehicle", "car"]]], T(), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
