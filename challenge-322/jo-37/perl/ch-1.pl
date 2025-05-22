#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $verbose, $size);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'size=i'  => \$size,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV && $size;

sub usage {
    die <<~EOS;
    $0 - string format

    usage: $0 [-examples] [-tests] [-size I STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -size I
        group size

    STR
        a string

    EOS
}


### Input and Output

say string_format(shift, $size);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/23/ch-322.html#task-1


sub string_format ($str, $i) {
    join '-', $str =~ tr/-//dr =~ /^.{1,$i}(?=(?:.{$i})*+$)|.{$i}/g;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = string_format(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["ABC-D-E-F", 3], "ABC-DEF", 'example 1'],
            [["A-BC-D-E", 2], "A-BC-DE", 'example 2'],
            [["-A-B-CD-E", 4], "A-BCDE", 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [1, 'a-b-c-d-e-f'],
            [2, 'ab-cd-ef'],
            [3, 'abc-def'],
            [4, 'ab-cdef'],
            [5, 'a-bcdef'],
            [6, 'abcdef'],
        );
        plan scalar @tests;
        is string_format('abcdef', $_->[0]), $_->[1], "size=$_->[0]" for @tests;
    }) : pass 'skip tests';

    exit;
}
