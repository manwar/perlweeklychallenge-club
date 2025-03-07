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
    $0 - Switch upper and lower case

    usage: $0 [-examples] [-tests] [WORD]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORD 
        a word

    EOS
}


### Input and Output

say xc(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/07/ch-311.html#task-1


sub xc ($str) {
    $str =~ s/(\p{Lu})|(\p{Ll})/$1 ? lc($1) : uc($2)/egr
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = xc(@$args);
        is $result, $expected,
            "$name: (@$args) ->  $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['pERl'], 'PerL', 'example 1'],
            [['rakU'], 'RAKu', 'example 2'],
            [['PyThOn'], 'pYtHoN', 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is xc('abc123DEF'), 'ABC123def', 'keep non-letters';
        is xc('Öl-Mühle'), 'öL-mÜHLE', 'non-ASCII';
    }) : pass 'skip tests';

    exit;
}
