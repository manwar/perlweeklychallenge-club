#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use Math::Complex;
use Regexp::Common;


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
    $0 - complex product

    usage: $0 [-examples] [-tests] [--] [C1 C2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    C1 C2
        two complex numbers in format x+yi or x+(-y)i

    EOS
}


### Input and Output

say complex_product(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/16/ch-395.html#task-2

sub complex_product (@num) {
    my $real = $RE{num}{real};
    my $num = qr{
        ^
        (?!\+)(-?$real)
        \+
        (?|
            (?![-+])($real)
            |
            \((?=-)($real)\)
        )
        i$
    }x;

    my ($c1, $c2) = map {
            my @n = /$num/;
            die "number invalid: $_" unless @n;
            cplx @n;
        } @num;
    my $prod = $c1 * $c2;

    sprintf '%s+%.*5$s%s%.*5$si', Re($prod), '(', Im($prod), ')',
        Im($prod) < 0;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = complex_product(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["1+1i", "1+1i"], "0+2i", 'example 1'],
            [["1+(-1)i", "1+(-1)i"], "0+(-2)i", 'example 2'],
            [["0+3i", "0+4i"], "-12+0i", 'example 3'],
            [["3+4i", "3+(-4)i"], "25+0i", 'example 4'],
            [["50+(-20)i","-10+30i"], "100+1700i", 'example 5'],
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
