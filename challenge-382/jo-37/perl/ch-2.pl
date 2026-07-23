#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'indexes';
use Math::Prime::Util 'todigits';
use List::Gather;

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
    $0 - replace question marks

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

say for replace_qm(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/07/17/ch-382.html#task-2

sub replace_qm {
    my @arr = split //, shift;
    my @qmi = indexes {$_ eq '?'} @arr;

    gather {
        local $" = '';
        for (0 .. 2**@qmi - 1) {
            @arr[@qmi] = todigits $_, 2, @qmi;
            take "@arr";
        }
    };
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = replace_qm(@$args);
        is \@result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["01??0"], ["01000", "01010", "01100", "01110"], 'example 1'],
            [["101"], ["101"], 'example 2'],
            [["???"], ["000", "001", "010", "011", "100", "101", "110", "111"],
                'example 3'],
            [["1?10"], ["1010", "1110"], 'example 4'],
            [["1?1?0"], ["10100", "10110", "11100", "11110"], 'example 5'],
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
