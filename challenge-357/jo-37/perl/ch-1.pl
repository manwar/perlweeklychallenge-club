#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(fromdigits todigits);


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
    $0 - Kaprekar constant

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a 4-digit number

    EOS
}


### Input and Output

say kaprekar(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/23/ch-357.html#task-1


use constant B => 10;
use constant L => 4;

sub kap ($x) {
    my @s = sort +todigits($x, B, L);
    fromdigits([reverse @s], B) - fromdigits([@s], B);
}

sub kaprekar ($x){
    my ($y, $z) = (0, 0);
    ($x, $y, $z) = (kap($x), $x, $z + 1) while $x != $y && $z < 20;
    die "not converging" if $z >= 20;
    $x ? $z - 1 : -1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = kaprekar(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[3524], 3, 'example 1'],
            [[6174], 0, 'example 2'],
            [[9998], 5, 'example 3'],
            [[1001], 4, 'example 4'],
            [[9000], 4, 'example 5'],
            [[1111], -1, 'example 6'],

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
