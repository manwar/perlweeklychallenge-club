#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Benchmark 'cmpthese';


### Options and Arguments

my ($tests, $examples, $benchmark, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'benchmark!'    => \$benchmark,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests, $benchmark);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - backspace compare

    usage: $0 [-examples] [-tests] [-benchmark] [STR1 STR2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -benchmark
        run benchmark

    STR1 STR2
        two strings

    EOS
}


### Input and Output

say +(qw(true false))[!bs_cmp(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/18/ch-321.html#task-2

sub apply_bs {
    my @out;
    $_ eq '#' ? pop @out : push @out, $_ for split //, shift;
    join '', @out;
}

sub bs_cmp ($str1, $str2) {
    apply_bs($str1) eq apply_bs($str2);
}

sub bs_cmp_subst ($str1, $str2) {
    for ($str1, $str2) {
        1 while s/.#//;
    }
    $str1 eq $str2;
}


### Examples and Tests

sub run_tests ($examples, $tests, $benchmark) {
    return unless $examples || $tests || $benchmark;

    state sub run_example ($args, $expected, $name) {
        my $result = bs_cmp(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 3;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["ab#c", "ad#c"], T(), 'example 1'],
            [["ab##", "a#b#"], T(), 'example 2'],
            [["a#b", "c"], F(), 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 4;
        ok bs_cmp("#abc", "abc"), 'leading bs';
        ok bs_cmp("a##", ""), 'bs moving to start';
        ok bs_cmp("###", ""), 'multiple leading bs';
        ok bs_cmp("abc#de###", "a"), 'delete a lot';
    }) : pass 'skip tests';

    $benchmark ? subtest_streamed(benchmark => sub {
        plan 2;
        my $str1 = 'a' x 1e5 . '#' x 1e5;
        my $str2 = '';
        ok bs_cmp($str1, $str2), 'check copy';
        ok bs_cmp_subst($str1, $str2), 'check subst';
        cmpthese(0, {
                subst => sub {bs_cmp_subst($str1, $str2)},
                copy => sub {bs_cmp($str1, $str2)},
            });
    }) : pass 'skip benchmark';

    exit;
}
