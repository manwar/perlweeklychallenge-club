#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
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
    $0 - special average

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

say special_average(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/12/12/ch-351.html#task-1

sub special_average {
    my $i = long @_;
    $i->where(!$i->in(long($i->minmax)))->avg;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = special_average(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[8000, 5000, 6000, 2000, 3000, 7000], 5250, 'example 1'],
            [[100_000, 80_000, 110_000, 90_000], 95_000, 'example 2'],
            [[2500, 2500, 2500, 2500], 0, 'example 3'],
            [[2000], 0, 'example 4'],
            [[1000, 2000, 3000, 4000, 5000, 6000], 3500, 'example 5'],
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
