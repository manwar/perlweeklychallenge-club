#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils qw(all slideatatime);


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
    $0 - ascending numbers

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string or a list of words

    EOS
}


### Input and Output

say +(qw(true false))[!ascending_numbers("@ARGV")];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-340.html#task-2


sub ascending_numbers ($str) {
    my $it = slideatatime 1, 2, grep /^\d+$/, split /\s+/, $str;
    while (my @pair = $it->()) {
        return if @pair > 1 && $pair[1] <= $pair[0];
    }
    1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = ascending_numbers(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["The cat has 3 kittens 7 toys 10 beds"], T(), 'example 1'],
            [["Alice bought 5 apples 2 oranges 9 bananas"], F(), 'example 2'],
            [["I ran 1 mile 2 days 3 weeks 4 months"], T(), 'example 3'],
            [["Bob has 10 cars 10 bikes"], F(), 'example 4'],
            [["Zero is 0 one is 1 two is 2"], T(), 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
