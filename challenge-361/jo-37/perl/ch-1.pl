#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Gather;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - Zeckendorf representation

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    N
        positive integer

    EOS
}


### Input and Output

say "@{[zeckendorf_representation(shift)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/13/ch-361.html#task-1

sub zeckendorf_representation ($n) {
    gather {
        while () {
            my ($f1, $f2) = (1, 1);
            ($f1, $f2) = ($f2, $f1 + $f2) while $n >= $f2;
            take $f1;
            $n -= $f1;
            last unless $n;
        }
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [zeckendorf_representation(@$args)];
        is $result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[20], [13, 5, 2], 'example 3'],
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
