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

usage() unless @ARGV == 2 && $ARGV[1] >= 0;

sub usage {
    die <<~EOS;
    $0 - text justifier

    usage: $0 [-examples] [-tests] [STR WIDTH]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    STR
        a string

    WIDTH
        a non-negative integer

    EOS
}


### Input and Output

say text_justifier(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/13/ch-360.html#task-1

sub text_justifier ($str, $width) {
    my $buf = '*' x $width;
    substr($buf, ($width - length($str)) / 2, length($str)) = $str;

    $buf;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = text_justifier(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["Hi", 5], "*Hi**", 'example 1'],
            [["Code", 10], "***Code***", 'example 2'],
            [["Hello", 9], "**Hello**", 'example 3'],
            [["Perl", 4], "Perl", 'example 4'],
            [["A", 7], "***A***", 'example 5'],
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
