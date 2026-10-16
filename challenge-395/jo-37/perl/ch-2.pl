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
    $0 - word square

    usage: $0 [-examples] [-tests] [WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORD...
        list of words

    EOS
}


### Input and Output

say for word_square(\@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/16/ch-395.html#task-1

sub word_square ($words, $head=[]) {
    my $prefix = '';
    $prefix .= substr($_, scalar @$head, 1) for @$head;
    for my $word (@$words) {
        next unless index($word, $prefix) == 0;
        return ($word) if length($word) == @$head + 1;
        my @tail = __SUB__->($words, [@$head, $word]);
        return ($word, @tail) if @tail;
    }
    ();
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = word_square($args);
        is \@result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["MA", "AM", "MY", "ME"],
                ["MA", "AM"], 'example 1'],
            [["SUN", "USE", "NET", "SEE", "TEN"],
                ["SUN", "USE", "NET"], 'example 2'],
            [["BOAT", "TEAL", "AREA", "TSAR", "OGRE"],
                ["BOAT", "OGRE", "AREA", "TEAL"], 'example 3'],
            [["CARD", "AREA", "REAR", "DART"],
                ["CARD", "AREA", "REAR", "DART"], 'example 4'],
            [["HEART", "TREND", "EMBER", "RESIN", "ABUSE"],
                ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"], 'example 5'],
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
