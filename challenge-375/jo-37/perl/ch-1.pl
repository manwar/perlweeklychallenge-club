#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils qw(listcmp singleton);
use List::Util 'pairmap';


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
    $0 - single common word

    usage: $0 [-examples] [-tests] [-verbose] [ARR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        print single common words

    ARR...
        arrays of blank separated words

    EOS
}


### Input and Output

main: {
    my @scw = scw(map [split], @ARGV);
    say $verbose ? "@scw" : scalar @scw;
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/29/ch-375.html#task-1

sub scw {
    pairmap {@$b == @_ ? $a : ()} &listcmp(map [singleton @$_], @_);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = scw(@$args);
        is $result, $expected,
            qq{$name: @{[map "(@$_)", @$args]} -> $expected};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[["apple", "banana", "cherry"], ["banana", "cherry", "date"]],
                2, 'example 1'],
            [[["a", "ab", "abc"], ["a", "a", "ab", "abc"]], 2, 'example 2'],
            [[["orange", "lemon"], ["grape", "melon"]], 0, 'example 3'],
            [[["test", "test", "demo"], ["test", "demo", "demo"]],
                0, 'example 4'],
            [[["Hello", "world"], ["hello", "world"]], 1, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is scalar scw([qw(a a b c d)], [qw(a b b c d)], [qw(a b c c d)]),
            1, 'three arrays';
        is scalar scw(([qw(a b)]) x 32), 2, 'more arrays';
    }) : pass 'skip tests';

    exit;
}
