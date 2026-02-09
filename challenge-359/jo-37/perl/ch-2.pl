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

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - reduce string

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say reduce_string(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/02/06/ch-359.html#task-2

sub reduce_string ($str) {
    1 while $str =~ s/(.)\1//g;
    $str;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = reduce_string(@$args);
        is $result, $expected,
            qq($name: "@$args" -> "$expected");
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["aabbccdd"], "", 'example 1'],
            [["abccba"], "", 'example 2'],
            [["abcdef"], "abcdef", 'example 3'],
            [["aabbaeaccdd"], "aea", 'example 4'],
            [["mississippi"], "m", 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["bcccb"], "bcb", 'odd number'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
