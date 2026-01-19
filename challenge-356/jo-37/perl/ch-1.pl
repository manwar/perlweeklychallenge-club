#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'sum0';

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
    $0 - kolakosi ones

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        count 1's in the Kolakosi sub-sequence of given order(s)

    EOS
}


### Input and Output

say kolakosi($_) for @ARGV;


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/16/ch-356.html#task-1

sub kolakosi ($k) {
    state $head = [1, 2];
    state $tail = [2];
    state $run = sub {
        push @$tail, (@$head % 2 + 1) x $tail->[0];
        push @$head, shift @$tail;
    };
    $run->() for @$head .. $k - 1;
    my $len = sum0 $head->@[0 .. $k - 1];
    scalar grep $_ == 1, (@$head, @$tail)[3 .. $len - 1];
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = kolakosi(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[4], 2, 'example 1'],
            [[5], 3, 'example 2'],
            [[6], 3, 'example 3'],
            [[7], 4, 'example 4'],
            [[8], 4, 'example 5'],
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
