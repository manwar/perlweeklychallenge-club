#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $verbose, $length);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'length=i'  => \$length,
) or usage();

$length //= 2;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - reverse exists

    usage: $0 [-examples] [-tests] [-length L] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -length L
        check substrings of length L

    STR
        a string

    EOS
}


### Input and Output

say +(qw(false true))[reverse_ex(shift, $length)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/06/12/ch-377.html#task-1

sub reverse_ex ($str, $length) {
    my $rev = reverse $str;

    0 + ($str =~ /(?=(.{$length})).(?(?{index($rev, $1) < 0})(*FAIL))/);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = reverse_ex(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["abcba", 2], T(), 'example 1'],
            [["racecar", 2], T(), 'example 2'],
            [["abcd", 2], F(), 'example 3'],
            [["banana", 2], T(), 'example 4'],
            [["hello", 2], T(), 'example 5'],
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
