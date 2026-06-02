#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'sum';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - chessboard squares

    usage: $0 [-examples] [-tests] [SQ1 SQ2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    SQ1 SQ2
        coordinates of two chessboard squares 'a1' ... 'h8'

    EOS
}


### Input and Output

say +(qw(false true))[same_color(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/06/05/ch-376.html#task-1

sub same_color {
    !(sum(map ord, map split(//), @_) % 2);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = same_color(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["a7", "f4"], T(), 'example 1'],
            [["c1", "e8"], F(), 'example 2'],
            [["b5", "h2"], F(), 'example 3'],
            [["f3", "h1"], T(), 'example 4'],
            [["a1", "g8"], F(), 'example 5'],
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
