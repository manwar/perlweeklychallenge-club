#!/usr/bin/perl

use v5.26;
use Test2::V0 '!float', float => {-as => 'float2'}, -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;


### Options and Arguments

my ($tests, $examples, $verbose, $income);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'income=f'  => \$income,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1 && defined $income;

sub usage {
    die <<~EOS;
    $0 - tax amount

    usage: $0 [-examples] [-tests] [-income I] [TAXES]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -income I
        income

    TAXES
        tax brackets in forms like 'u1, t1; u2, t2;...' or
        '[u1, t1], [u2, t2],...'

    EOS
}


### Input and Output

say tax_amount($income, tax_pp(shift));


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/30/ch-323.html#task-2


sub tax_pp {
    my $tax = pdl @_;
    $tax(1) /= 100;
    my $low = pdl(0)->append($tax((0)));

    cat $low,
        $tax((1))->append(pdl(0)),
        pdl(0)->append((($low(1:-1) - $low(0:-2)) * $tax((1)))->cumusumover);
}

sub tax_amount ($income, $tp) {
    my $tax = $tp(vsearch_bin_inclusive($income, $tp(,(0)));-);

    sclr $tax(2) + $tax(1) * ($income - $tax(0));
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = tax_amount($args->[0], tax_pp($args->[1]));
        is $result, float2($expected, precision => 2),
            "$name: ($args->[0], (" .
            (join ' ', map "[@$_]", $args->[1]->@*) .
            ")) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[10, [[3, 50], [7, 10], [12,25]]], 2.65, 'example 1'],
            [[2, [[1, 0], [4, 25], [5,50]]], .25, 'example 2'],
            [[0, [[2, 50]]], 0, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @examples = (
            [2, 1, 'first slot'],
            [3, 1.5, 'end of first slot'],
            [5, 1.7, 'second slot'],
            [7, 1.9, 'end of second slot'],
            [12, 3.15, 'end of third slot'],
            [14, 3.15, 'last slot'],
            [2.6, 1.3, 'broken income'],
        );
        my $tp = tax_pp([3, 50], [7, 10], [12,25]);
        plan scalar @examples;
        is tax_amount($_->[0], $tp), float2($_->[1], precision => 2), $_->[2]
            for @examples;
    }) : pass 'skip tests';

    exit;
}
