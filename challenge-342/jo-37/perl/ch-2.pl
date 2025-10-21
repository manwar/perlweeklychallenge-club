#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
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
    $0 - max score

    usage: $0 [-examples] [-tests] [BIN]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    BIN
        binary number

    EOS
}


### Input and Output

say max_score(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-342.html#task-2


sub max_score {
    my $bin = long split //, shift;
    max +(1 - $bin)->(0:-2)->cumusumover + $bin(-1:1)->cumusumover->(-1:0);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = max_score(@$args);
        is $result, $expected,
            "$name: ('@$args') -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['0011'], 4, 'example 1'],
            [['0000'], 3, 'example 2'],
            [['1111'], 3, 'example 3'],
            [['0101'], 3, 'example 4'],
            [['011101'], 5, 'example 5'],
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
