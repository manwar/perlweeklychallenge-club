#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'part';
use Math::Prime::Util 'todigits';


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
    $0 - convert to base

    usage: $0 [-examples] [-tests] [N B]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a non-negative integer

    B
        a positive integer

    EOS
}


### Input and Output

say to_base(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/07/31/ch-384.html#task-1

sub to_base ($num, $base) {
    state $digits = [map @$_, part {/[[:punct:]]/}
        grep /[[:alnum:][:punct:]]/, map chr, 0 .. 127];
    die "base too large" if $base > @$digits;

    join '', $digits->@[todigits $num, $base];
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = to_base(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[       42,  2], '101010', 'example 1'],
            [[ 15642094, 16], 'EEADEE', 'example 2'],
            [[      493,  8], '755',    'example 3'],
            [[  2228519, 36], '1BRJB',  'example 4'],
            [[123456789, 64], '7MyqL',  'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        like to_base(652859770833, 94), qr/^_`\{\|\}~$/, 'last 6 digits';
    }) : pass 'skip tests';

    exit;
}
