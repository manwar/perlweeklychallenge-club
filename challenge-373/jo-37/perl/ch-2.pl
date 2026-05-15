#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::UtilsBy 'bundle_by';
use List::Gather;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 1 && $ARGV[0] > 0;

sub usage {
    die <<~EOS;
    $0 - list division

    usage: $0 [-examples] [-tests] [-verbose] [N L...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        number of chunks

    L...
        list of numbers

    EOS
}


### Input and Output

main: {
    my @division = list_division(@ARGV);
    say @division ? map "(@$_)", @division : -1;
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/15/ch-373.html#task-2

sub list_division ($n, @list) {
    return () if $n > @list;
    my $chunk_size = 1 + int @list / $n;
    my @head = splice @list, 0, $chunk_size * (@list % $n);

    gather {
        bundle_by {take [@_]} $chunk_size--, @$_ for \@head, \@list;
    };
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [list_division(@$args)];
        is $result, $expected,
            qq{$name: ($args->[0] -> $args->@[1..$#$args]) -> @{[map "(@$_)", @$expected]}};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[2 ,=> 1,2,3,4,5],
                [[1,2,3], [4,5]],
                'example 1'],
            [[3 ,=> 1,2,3,4,5,6],
                [[1,2], [3,4], [5, 6]],
                'example 2'],
            [[2 ,=> 1,2,3],
                [[1,2], [3]],
                'example 3'],
            [[5 ,=> 1,2,3,4,5,6,7,8,9,10],
                [[1,2], [3,4], [5,6], [7,8], [9,10]],
                'example 4'],
            [[4 ,=> 1,2,3],
                [],
                'example 5'],
            [[7 ,=> 72,57,89,55,36,84,10,95,99,35],
                [[72,57], [89,55], [36,84], [10], [95], [99], [35]],
                'example 6'],
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
