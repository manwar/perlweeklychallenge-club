#!/usr/bin/perl

use v5.26;
use Test2::V0 '!float', -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::Char;
use PDL::NiceSlice;


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
    $0 - sort column

    usage: $0 [-examples] [-tests] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR...
        list of strings

    EOS
}


### Input and Output

say sort_column(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/28/ch-314.html#task-2


sub sort_column {
    my $m = PDL::Char->new(@_)->long->xchg(0, 1);

    sum orover $m(1:-1) < $m(0:-2);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = sort_column(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["swpc", "tyad", "azbe"], 2, 'example 1'],
            [["cba", "daf", "ghi"], 1, 'example 2'],
            [["a", "b", "c"], 0, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is sort_column('a', 'bc', 'def'), 0, 'different lengths, short first';
        is sort_column('abc', 'de', 'f'), 2, 'different lengths, long first';
        is sort_column('aaa', 'bbc', 'dee'), 0, 'accept equal';
    }) : pass 'skip tests';

    exit;
}
