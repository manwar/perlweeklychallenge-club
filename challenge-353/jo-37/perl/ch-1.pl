#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use List::Util 'max';


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
    $0 - max words

    usage: $0 [-examples] [-tests] [-verbose] [SENTENCE...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    SENTENCE...
        list of sentences

    EOS
}


### Input and Output

say max_words(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/12/26/ch-353.html#task-1

sub max_words {
    max map scalar(() = /\w+/g), @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = max_words(@$args);
        is $result, $expected,
            "$name: (@{[map qq('$_'), @$args]}) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["Hello world", "This is a test", "Perl is great"], 4,
                'example 1'],
            [["Single"], 1, 'example 2'],
            [["Short", "This sentence has seven words in total",
                    "A B C", "Just four words here"], 7, 'example 3'],
            [["One", "Two parts", "Three part phrase", ""], 3, 'example 4'],
            [["The quick brown fox jumps over the lazy dog", "A",
                    "She sells seashells by the seashore",
                    "To be or not to be that is the question"], 10,
                'example 5'],
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
