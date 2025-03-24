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
    $0 - equal strings

    usage: $0 [-examples] [-tests] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR...
        list of strings

    EOS
}


### Input and Output

say equal_strings(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/28/ch-314.html#task-1

sub equal_strings {
    my $str = join "\n", @_;
    $str =~ /^(.+).*+(?:\n\1.*+){$#_}$/ or return -1;

    length($str) - (1 + length $1) * @_ + 1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = equal_strings(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["abc", "abb", "ab"], 2, 'example 1'],
            [["ayz", "cyz", "xyz"], -1, 'example 2'],
            [["yza", "yzb", "yzc"], 3, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is equal_strings('ab', 'abc', 'abcd', 'abcde'), 6, 'four strings';
        is equal_strings('abc', 'abc'), 0, 'two equal strings';
        is equal_strings('abc'), 0, 'single string';
    }) : pass 'skip tests';

    exit;
}
