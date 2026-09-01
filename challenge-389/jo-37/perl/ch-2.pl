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
    $0 - zig zag subarray

    usage: $0 [-examples] [-tests] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers

    EOS
}


### Input and Output

say zig_zag(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/09/04/ch-389.html#task-2

sub zig_zag {
    return 1 if @_ < 2;
    my $arr = long @_;
    my $steps = $arr(0:-2) <=> $arr(1:-1);
    $steps *= (-1)**sequence $steps;
    my ($len, $val) = rle $steps;

    ($len * $val->abs)->max + 1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = zig_zag(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[9, 4, 2, 10, 7, 8, 8, 1, 9], 5, 'example 1'],
            [[1, 7, 4, 9, 2, 5], 6, 'example 2'],
            [[1, 2, 3, 4, 5], 2, 'example 3'],
            [[4, 4, 4], 1, 'example 4'],
            [[10, 20, 15, 12, 18], 3, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is zig_zag(3, 5, 2, 8, 1, 1, 1, 1, 1, 1), 5, 'many equal';
    }) : pass 'skip tests';

    exit;
}
