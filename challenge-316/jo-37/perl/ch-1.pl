#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

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
    $0 - Circular

    usage: $0 [-examples] [-tests] [WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORD...
        list or words

    EOS
}


### Input and Output

say +(qw(true false))[!circular(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/11/ch-316.html#task-1

sub circular {
    join("\n", @_) =~ /^(?:.*+(?<=(.))\n(?=\1))*+.*+$/;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = circular(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["perl", "loves", "scala"], T(), 'example 1'],
            [["love", "the", "programming"], F(), 'example 2'],
            [["java", "awk", "kotlin", "node.js"], T(), 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is circular("xy"), T(), 'single word';
        is circular("tea", "a",  "axe"), T(), 'single letter';
        is circular("ab", "bc", "de"), F(), 'fail at end';
    }) : pass 'skip tests';

    exit;
}
