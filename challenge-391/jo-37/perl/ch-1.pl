#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use POSIX 'Inf';


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
    $0 - array median

    usage: $0 [-examples] [-tests] [--] [L1 L2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    L1 L2
        two sorted lists of whitespace separated integers

    EOS
}


### Input and Output

say array_median(map [split], @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/04/ch-391.html#task-1

sub array_median ($arr1, $arr2) {
    my @arr1 = @$arr1;
    my @arr2 = @$arr2;
    my $i1 = int((@arr1 + @arr2 - 1) / 2);
    my $i2 = int((@arr1 + @arr2) / 2);
    my @merge;
    while ($#merge < $i2) {
        push @merge,
            ($arr1[0] // Inf) <= ($arr2[0] // Inf) ?
            shift @arr1 : shift @arr2;
    }

    ($merge[$i1] + $merge[$i2]) / 2;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = array_median(@$args);
        is $result, $expected,
            qq{$name: (@{[map "(@$_)", @$args]}) -> } . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[2], [4]], float(3), 'example 1'],
            [[[1, 2, 3], [7, 8, 9, 10]], float(7), 'example 2'],
            [[[], [10, 20, 30, 40]], float(25), 'example 3'],
            [[[100], [1, 2, 3, 4, 5, 6, 7]], float(4.5), 'example 4'],
            [[[1, 2, 2], [2, 2, 3]], float(2), 'example 5'],
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
