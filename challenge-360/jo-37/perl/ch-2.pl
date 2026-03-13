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
    $0 - word sorter

    usage: $0 [-examples] [-tests]  [WORDS...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORDS...
        list of words

    EOS
}


### Input and Output

say word_sorter("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/13/ch-360.html#task-2

sub word_sorter {
    join ' ', map $_->[1],
        sort {$a->[0] cmp $b->[0]} map [fc, $_], split /\s+/, shift;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = word_sorter(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["The quick brown fox"], "brown fox quick The", 'example 1'],
            [["Hello    World!   How   are you?"], "are Hello How World! you?",
                'example 2'],
            [["Hello"], "Hello", 'example 3'],
            [["Hello, World! How are you?"], "are Hello, How World! you?",
                'example 4'],
            [["I have 2 apples and 3 bananas!"],
                "2 3 and apples bananas! have I", 'example 5'],
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
