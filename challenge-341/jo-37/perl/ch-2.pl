#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $verbose, $chr);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'chr=s'    => \$chr,
) or usage();

$chr //= '';

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - Task Title

    usage: $0 [-examples] [-tests]  [-chr C STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -char C
        a character

    STR
        a string

    EOS
}


### Input and Output

say reverse_prefix($chr, shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-341.html#task-2

sub reverse_prefix ($chr, $str) {
    $str =~ s/.*?$chr/reverse $&/er;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = reverse_prefix(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[qw(g programming)], 'gorpramming', 'example 1'],
            [[qw(h hello)], 'hello', 'example 2'],
            [[qw(h abcdefghij)], 'hgfedcbaij', 'example 3'],
            [[qw(s reverse)], 'srevere', 'example 4'],
            [[qw(r perl)], 'repl', 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[qw(d abc)], 'abc', 'not found'],
            [[qw(de abcdefg)], 'edcbafg', 'search string'],
            [['', 'abc'], 'abc', 'no char'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
