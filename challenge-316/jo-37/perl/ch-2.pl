#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

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
    $0 - Subsequence

    usage: $0 [-examples] [-tests] [STR1 STR2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR1
        a string

    STR2
        another string

    EOS
}


### Input and Output

say +(qw(true false))[!subsequence(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/11/ch-316.html#task-2


sub subsequence ($str1, $str2) {
    $str2 =~ ($str1 =~ s/./\Q$&\E.*/gr);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = subsequence(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["uvw", "bcudvew"], T(), 'example 1'],
            [["aec", "abcde"], F(), 'example 2'],
            [["sip", "javascript"], T(), 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is subsequence('...', 'abc'), F(), 'do not match metachars';
        is subsequence('...', 'a.b.c.d'), T(), 'match metachars';

    }) : pass 'skip tests';

    exit;
}
