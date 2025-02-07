#!/usr/bin/perl

use v5.26;
use Test2::V0 '!float';
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
    $0 - odd sum

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests and
        print weights for L = 1..10

    N...
        list of numbers

    EOS
}


### Input and Output

say odd_sum(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/31/ch-306.html#task-1

sub weight ($n) {
    my $k = int +($n + 1) / 2;
    cat((1 + sequence $n)->(*$k),
        ($n - sequence $n)->(*$k),
        (1 + 2 * sequence $k)->(,*$n),
        ($n - 2 * sequence $k)->(,*$n)
    )->mv(2, 0)->minover->sumover;
}

sub odd_sum {
    my $l = long [@_];
    inner($l, weight($l->dim(0)))->sclr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = odd_sum(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[2, 5, 3, 6, 4], 77, 'example 1'],
            [[1, 3], 4, 'example 2'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        say weight($_) for 1 .. 10;
        is odd_sum(20, 15, 12, 15, 20), 300, '60 * 5';
    }) : pass 'skip tests';

    exit;
}
