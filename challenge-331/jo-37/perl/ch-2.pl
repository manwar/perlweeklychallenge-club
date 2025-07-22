#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL v2.100;
use PDL::NiceSlice;

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - buddy strings

    usage: $0 [-examples] [-tests] [SOURCE TARGET]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    SOURCE TARGET
        two strings

    EOS
}


### Input and Output

say +(qw(true false))[!buddy_strings(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/07/25/ch-331.html#task-2


sub buddy_strings {
    my $s = long map [map ord, split //], @_;
    my $diff = which $s->xchg(0, 1)->bxorover;

    $diff->isempty && $s(,0)->uniq->dim(0) < $s->dim(0) ||
    $diff->nelem == 2 && all $s($diff,0) == $s($diff(-1:0),1);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = buddy_strings(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["fuck", "fcuk"], T(), 'example 1'],
            [["love", "love"], F(), 'example 2'],
            [["fodo", "food"], T(), 'example 3'],
            [["feed", "feed"], T(), 'example 4'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["this", "thus"], F(), 'one different char'],
            [["this", "then"], F(), 'two different chars'],
            [["the", "thee"], F(), 'different lengths'],
            [["seprű", "sűpre"], T(), 'beyond U+00FF'],
            [["hour", "ouhr"], F(), 'rotated'],
            [["hour", "ohru"], F(), 'two flips'],
            [["aaa", "aaa"], T(), 'more non-unique chars'],

        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
