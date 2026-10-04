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
    $0 - word length product

    usage: $0 [-examples] [-tests] [W...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    W...
        list of words

    EOS
}


### Input and Output

say word_length_product(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/04/ch-392.html#task-2

sub word_length_product {
    my $wlp = 0;
    while (my $w1 = shift) {
        my $r = qr([\Q$w1\E]);
        for my $w2 (@_) {
            if ($w2 !~ $r) {
                my $p = length($w1) * length($w2);
                $wlp = $p if $p > $wlp;
            }
        }
    }

    $wlp;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = word_length_product(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["a", "ab", "abc", "d", "de", "def"],    9, 'example 1'],
            [["a", "aa", "aaa", "aaaa"],              0, 'example 2'],
            [["meet", "app", "code", "sky", "bold"], 16, 'example 3'],
            [["a", "ab", "abc", "abcd", "efghi"],    20, 'example 4'],
            [["xyz", "w", "abcdefg", "hij"],         21, 'example 5'],
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
