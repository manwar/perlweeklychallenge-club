#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'pairs';
use List::MoreUtils 'frequency';
use List::UtilsBy 'max_by';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 1;

sub usage {
    die <<~EOS;
    $0 - popular word

    usage: $0 [-examples] [-tests] [-verbose] [STR BANNED...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    BANNED...
        list of banned words

    EOS
}


### Input and Output

say popular_word(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/24/ch-370.html#task-1

sub popular_word ($str, @banned) {
    my $banned = join '|', map quotemeta, @banned;
   
    (max_by {$_->[1]}
        pairs
        frequency
        grep !/^(?:$banned)$/,
        lc($str) =~ /[a-z]+/g
    )->[0];
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = popular_word(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['Bob hit a ball, the hit BALL flew far after it was hit.',
                'hit'], 'ball', 'example 1'],
            [['Apple? apple! Apple, pear, orange, pear, apple, orange.',
                'apple', 'pear'], 'orange', 'example 2'],
            [['A. a, a! A. B. b. b.',
                'b'], 'a', 'example 3'],
            [['Ball.ball,ball:apple!apple.banana',
                'ball'], 'apple', 'example 4'],
            [['The dog chased the cat, but the dog was faster than the cat.',
                'dog', 'cat'], 'the', 'example 5'],
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
