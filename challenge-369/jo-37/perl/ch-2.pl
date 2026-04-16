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

usage() unless @ARGV == 3;

sub usage {
    die <<~EOS;
    $0 - group division

    usage: $0 [-examples] [-tests] [-verbose] [STR SIZE FILL]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string
    SIZE
        group size
    FILL
        fill character

    EOS
}


### Input and Output

say qq{@{[map qq{"$_"}, group_division(@ARGV)]}};


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/17/ch-369.html#task-2

sub group_division ($str, $size, $filler) {
    ($str . $filler x ($size - 1)) =~ /.{$size}/g;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = group_division(@$args);
        is \@result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["RakuPerl", 4, "*"], ["Raku", "Perl"], 'example 1'],
            [["Python", 5, "0"], ["Pytho", "n0000"], 'example 2'],
            [["12345", 3, "x"], ["123", "45x"], 'example 3'],
            [["HelloWorld", 3, "_"], ["Hel", "loW", "orl", "d__"],
                'example 4'],
            [["AI", 5, "!"], ["AI!!!"], 'example 5'],
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
