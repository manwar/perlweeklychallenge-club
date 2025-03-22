#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'indexes';

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
    $0 - Task Title

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

say reverse_letters(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/21/ch-313.html#task-2


sub reverse_letters {
    my @s = shift =~ /\X/g;
    my @li = indexes {/\p{L}/} @s;
    @s[@li] = @s[reverse @li];
    join '', @s;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = reverse_letters(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["p-er?l"], "l-re?p", 'example 1'],
            [["wee-k!L-y"], "yLk-e!e-w", 'example 2'],
            [["_c-!h_all-en!g_e"], "_e-!g_nel-la!h_c", 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is reverse_letters("a\N{COMBINING DIAERESIS},o&u"),
            "u,o&a\N{COMBINING DIAERESIS}", 'operate on grapheme clusters';
    }) : pass 'skip tests';

    exit;
}
