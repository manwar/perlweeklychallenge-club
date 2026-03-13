#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use PDL;


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
    $0 - find celebrity

    usage: $0 [-examples] [-tests] [PARTY]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    PARTY
        binary NxN matrix of "who knows whom" in any form accepted by the
        PDL string constructor, e.g. '0 1 0; 0 0 0; 0 1 0' or
        '[0 1 0]' '[0 0 0]' '[0 1 0]'

    EOS
}


### Input and Output

say find_celebrity("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/13/ch-361.html#task-2

sub find_celebrity {
    my $party = long(@_)->copy;
    $party->badflag(1);
    $party->diagonal(0, 1) .= $party->badvalue;
    my $celeb = which !$party->orover * $party->xchg(0, 1)->andover;
    $celeb->isempty ? -1 : $celeb->sclr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = find_celebrity(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[long(
                    [0, 0, 0, 0, 1, 0],  # 0 knows 4
                    [0, 0, 0, 0, 1, 0],  # 1 knows 4
                    [0, 0, 0, 0, 1, 0],  # 2 knows 4
                    [0, 0, 0, 0, 1, 0],  # 3 knows 4
                    [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
                    [0, 0, 0, 0, 1, 0],  # 5 knows 4
                )], 4, 'example 1'],
            [[long(
                    [0, 1, 0, 0],  # 0 knows 1
                    [0, 0, 1, 0],  # 1 knows 2
                    [0, 0, 0, 1],  # 2 knows 3
                    [1, 0, 0, 0]   # 3 knows 0
                )], -1, 'example 2'],
            [[long(
                    [0, 0, 0, 0, 0],  # 0 knows NOBODY
                    [1, 0, 0, 0, 0],  # 1 knows 0
                    [1, 0, 0, 0, 0],  # 2 knows 0
                    [1, 0, 0, 0, 0],  # 3 knows 0
                    [1, 0, 0, 0, 0]   # 4 knows 0
                )], 0, 'example 3'],
            [[long(
                    [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
                    [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
                    [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
                    [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
                    [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
                    [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
                )], 3, 'example 4'],
            [[long(
                    [0, 1, 1, 0],  # 0 knows 1 and 2
                    [1, 0, 1, 0],  # 1 knows 0 and 2
                    [0, 0, 0, 0],  # 2 knows NOBODY
                    [0, 0, 0, 0]   # 3 knows NOBODY
                )], -1, 'example 5'],
            [[long(
                    [0, 0, 1, 1],  # 0 knows 2 and 3
                    [1, 0, 0, 0],  # 1 knows 0
                    [1, 1, 0, 1],  # 2 knows 0, 1 and 3
                    [1, 1, 0, 0]   # 3 knows 0 and 1
                )], -1, 'example 6'],
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
