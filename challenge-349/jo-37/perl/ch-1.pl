#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::Char;

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
    $0 - power string

    usage: $0 [-examples] [-tests] [-verbose] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say power_string(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/28/ch-349.html#task-1

sub power_string {
    (PDL::Char->new(shift)->long->rle)[0]->max;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = power_string(@$args);
        is $result, $expected,
            "$name: '@$args' -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['textbook'], 2, 'example 1'],
            [['aaaaa'], 5, 'example 2'],
            [['hoorayyy'], 3, 'example 3'],
            [['x'], 1, 'example 4'],
            [['aabcccddeeffffghijjk'], 4, 'example 5'],
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
