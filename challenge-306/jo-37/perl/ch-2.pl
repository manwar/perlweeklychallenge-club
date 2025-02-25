#!/usr/bin/perl

use v5.26;
use Test2::V0;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils qw(nsort_by binsert);


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
    $0 - last element

    usage: $0 [-examples] [-tests] [-verbose] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of numbers

    EOS
}


### Input and Output

say last_element(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/31/ch-306.html#task-2


sub last_element {
    my @list = nsort_by {$_} @_;
    while (@list > 1) {
        my ($m1, $m2) = splice @list, -2;
        my $diff = $m2 - $m1;
        next unless $diff;
        binsert {$_ <=> $diff} $diff, @list;
    }
    $list[0] // 0;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = last_element(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[3, 8, 5, 2, 9, 2], 1, 'example 1'],
            [[3, 2, 5], 0, 'example 2'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 8;
        is last_element(map 2**$_ - 1, 1 .. $_), $_, 2**$_ - 1 for 1 .. 8;
    }) : pass 'skip tests';

    exit;
}
