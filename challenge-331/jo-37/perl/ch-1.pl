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
    $0 - length of last word

    usage: $0 [-examples] [-tests] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR...
        string or list of words

    EOS
}


### Input and Output

say llw("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/07/25/ch-331.html#task-1


sub llw {
    () = shift =~ /\w+/g or return 0;
    $+[0] - $-[0];
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = llw(@$args);
        is $result, $expected,
            qq($name: "@$args" -> $expected);
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["The Weekly Challenge"], 9, 'example 1'],
            [["   Hello   World    "], 5, 'example 2'],
            [["Let's begin the fun"], 3, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is llw('... --- +++ ///   '), 0, 'no word';
        is llw("it isn't"), 1, 'part only';
    }) : pass 'skip tests';

    exit;
}
