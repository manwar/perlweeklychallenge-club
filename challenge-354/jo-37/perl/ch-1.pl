#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
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
    $0 - min abs diff

    usage: $0 [-examples] [-tests] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of numbers

    EOS
}


### Input and Output

say min_diff(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/02/ch-354.html#task-1

sub min_diff {
    my $i = long @_;
    my $diff = $i->dummy(0) - $i;
    $diff->badflag(1);
    $diff->where($diff <= 0) .= $diff->badvalue;
    qsortvec $i->index1d(scalar whichND $diff == $diff->min);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = min_diff(@$args);
        pdl_is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[4, 2, 1, 3], long([1, 2], [2, 3], [3, 4]), 'example 1'],
            [[10, 100, 20, 30], long([10, 20], [20, 30]), 'example 2'],
            [[-5, -2, 0, 3], long([[-2, 0]]), 'example 3'],
            [[8, 1, 15, 3], long([[1, 3]]), 'example 4'],
            [[12, 5, 9, 1, 15], long([9, 12], [12, 15]), 'example 5'],
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
