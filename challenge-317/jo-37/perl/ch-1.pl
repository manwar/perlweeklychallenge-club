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

usage() unless @ARGV > 1;

sub usage {
    die <<~EOS;
    $0 - acronym

    usage: $0 [-examples] [-tests] [WORD STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORD
        a word

    STR...
        list of words

    EOS
}


### Input and Output

say +(qw(true false))[!acronyms(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/17/ch-317.html#task-1


sub acronyms ($word, @array) {
    $word eq join '', map /(.)/, @array;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = acronyms(@$args);
        my $acronym = shift @$args;
        is $result, $expected,
            "$name: ($acronym => @$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[PWC => "Perl", "Weekly", "Challenge"], T(), 'example 1'],
            [[BCJ => "Bob", "Charlie", "Joe"], T(), 'example 2'],
            [[MM => "Morning", "Good"], F(), 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
