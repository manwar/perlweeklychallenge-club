#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;

### Options and Arguments

my ($tests, $examples, $verbose, $from, $to);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'from=i'    => \$from,
    'to=i'      => \$to,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV && defined($from) && defined($to);

sub usage {
    die <<~EOS;
    $0 - range sum

    usage: $0 [-examples] [-tests] [-from F -to T N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -from F
        start index

    -to T
        end index

    N...
        list of numbers

    EOS
}


### Input and Output

say range_sum($from, $to, @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/17/ch-334.html#task-1


sub range_sum ($x, $y, @ints) {
    pdl(@ints)->($x:$y)->sum;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = range_sum(@$args);
        is $result, $expected,
            "$name: ($args->@[2..$#$args]), x=$args->[0], y=$args->[1] -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[(0, 2) ,=> (-2, 0, 3, -5, 2, -1)], 1, 'example 1'],
            [[(1, 3) ,=> (1, -2, 3, -4, 5)], -3, 'example 2'],
            [[(3, 4) ,=> (1, 0, 2, -1, 3)], 2, 'example 3'],
            [[(0, 3) ,=> (-5, 4, -3, 2, -1, 0)], -2, 'example 4'],
            [[(0, 2) ,=> (-1, 0, 2, -3, -2, 1)], 1, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[(1, 2) ,=> (1, 2, 4, 8, 16)], 6, 'std'],
            [[(2, 1) ,=> (1, 2, 4, 8, 16)], 6, 'reverse'],
            [[(1, -3) ,=> (1, 2, 4, 8, 16)], 6, 'y from end'],
            [[(-4, 2) ,=> (1, 2, 4, 8, 16)], 6, 'x from end'],
            [[(-4, -3) ,=> (1, 2, 4, 8, 16)], 6, 'both from end'],
            [[(-3, -4) ,=> (1, 2, 4, 8, 16)], 6, 'both from end, reverse'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
