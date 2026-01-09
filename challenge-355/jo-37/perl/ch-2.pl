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

usage() unless @ARGV >= 3;

sub usage {
    die <<~EOS;
    $0 - mountain array

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

say +(qw(true false))[!mountain(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/09/ch-355.html#task-2

sub mountain {
    state $p = long '1 -1; 1 1; -1 -1';
    my $v = eqvec +(long(@_)->diff2 <=> 0)
        ->lags(0, 1, 2)->xchg(0, 1)->(-1:0)->dummy(1), $p;

    $v->orover->andover && $v((0))->orover;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = mountain(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 2, 3, 4, 5], F(), 'example 1'],
            [[0, 2, 4, 6, 4, 2, 0], T(), 'example 2'],
            [[5, 4, 3, 2, 1], F(), 'example 3'],
            [[1, 3, 5, 5, 4, 2], F(), 'example 4'],
            [[1, 3, 2], T(), 'example 5'],
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
