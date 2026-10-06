#!/usr/bin/perl

use v5.26;
use Test2::V0 '-no_srand';
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use feature 'bitwise';

use List::Util 'min';


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
    $0 - alternate case

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        an alphabetic string

    EOS
}


### Input and Output

say alternate_case(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/09/ch-394.html#task-1

sub alternate_case ($str) {
    state sub alt ($s) {
        my $c = 0;
        $c += length($&) - 1 while $s =~ s/0(?:11)*0/'1' x length($&)/e;
        die "invalid string" if $s =~ /0/;
        $c;
    }

    $str =~ tr/a-zA-Z//c && die 'non-letter character';
    my $m = $str =~ tr/a-z/0/r
            =~ tr/A-Z/1/r
            =~ s/../$& ^. "\0\1"/ger;

    min alt($m), alt($m =~ tr/01/10/r);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = alternate_case(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["aAbB"], 0, 'example 1'],
            [["AAbb"], 1, 'example 2'],
            [["AAAbbb"], 3, 'example 3'],
            [["aABb"], 1, 'example 4'],
            [["bBBAaa"], 2, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["lulUlulULUlULU"], 14, 'example o-e-o'],
            [["lulULUlULUlulU"], 6, 'example e-o-e'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
