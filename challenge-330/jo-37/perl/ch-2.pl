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
    $0 - title capital

    usage: $0 [-examples] [-tests] [WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORD...
        list of words or strings

    EOS
}


### Input and Output

say title_capital("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/07/18/ch-330.html#task-2


sub title_capital {
    lc(shift) =~ s/\w{3,}/\u$&/gr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = title_capital(@$args);
        is $result, $expected,
            "$name: '@$args' -> '$expected'";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["PERL IS gREAT"], "Perl is Great" , 'example 1'],
            [["THE weekly challenge"], "The Weekly Challenge", 'example 2'],
            [["YoU ARE A stAR"], "You Are a Star" , 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["ǇETo sUMMER sommer"], "ǈeto Summer Sommer",
                'titlecase digraph'],
            [["ÜBLER ärger mit Öl"], "Übler Ärger Mit öl" , 'Umlauts'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
