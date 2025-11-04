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

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - longest parenthesis

    usage: $0 [-examples] [-tests] [-verbose] [--] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    STR
        a string consisting of '(' and ')' only

    EOS
}


### Input and Output

say longest_parenthesis(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/07/ch-346.html#task-1

sub longest_parenthesis {
    my $max = 0;
    shift =~ m{
        (
            (?:
                \(
                (?1)?
                \)
            )+
        )
        (?{length($1) > $max and $max = length($1)})
        (*FAIL)
    }x;
    $max;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo;
        $todo = todo $reason if $reason;
        my $result = longest_parenthesis(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['(()())'], 6, 'example 1'],
            [[')()()))'], 4, 'example 2'],
            [['((()))()(((()'], 8, 'example 3'],
            [['))))((()('], 2, 'example 4'],
            [['()(()'], 2, 'example 5'],
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
