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

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - decrypt string

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

say decrypt_string(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/13/ch-364.html#task-1

sub decrypt_string {
    state $alpha = ['a'..'z'];
    shift =~ s/(?|(1[0-9]|2[0-6])#|([1-9]))/$alpha->[$1 - 1]/gr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = decrypt_string(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["10#11#12"],  "jkab",  'example 1'],
            [["1326#"],     "acz",   'example 2'],
            [["25#24#123"], "yxabc", 'example 3'],
            [["20#5"],      "te",    'example 4'],
            [["1910#26#"],  "aijz",  'example 5'],
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
