#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 3;

sub usage {
    die <<~EOS;
    $0 - max diff

    usage: $0 [-examples] [-tests] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of at least four numbers

    EOS
}


### Input and Output

say max_diff(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-339.html#task-1

sub max_diff (@n) {
    my $n = long @n;
    $n->badflag(1);
    my $pd = null;
    for my $subs ([\&find_max, \&find_min, 1], [\&find_min, \&find_max, -1]) {
        my $nc = $n->copy;
        my $m1 = &{$subs->[0]}($nc);
        my $m2 = &{$subs->[1]}($nc->where($nc->isgood));
        $pd = $pd->append($subs->[2] * ($m1 - $m2));
    }

    max $pd;
}

sub remove_prod ($l) {
    my $prod = $l->prod;
    $l .= $l->badvalue;

    $prod;
}

sub find_max ($n) {
    goto &remove_prod if $n->nelem == 2;

    my ($pos, $neg) = which_both $n >= 0;
    my $max_ind = null;
    if ($pos->nelem >= 2) {
        $max_ind = $max_ind->glue(1, maximum_n_ind($n, 2));
    }
    if ($neg->nelem >= 2) {
        $max_ind = $max_ind->glue(1, minimum_n_ind($n, 2));
    }
    my $max = $n->index1d($max_ind)->prodover->maximum_ind;

    remove_prod($n($max_ind(,($max))));
}

sub find_min ($n) {
    goto &remove_prod if $n->nelem == 2;

    my ($pos, $neg) = which_both $n >= 0;
    if (!$neg->isempty && !$pos->isempty) {
        return remove_prod($n(cat(($n->minmaximum)[2, 3])));
    } elsif ($pos->isempty) {
        return remove_prod($n(maximum_n_ind($n, 2)));
    } else {
        return remove_prod($n(minimum_n_ind($n, 2)));
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = max_diff(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[5, 9, 3, 4, 6], 42, 'example 1'],
            [[1, -2, 3, -4], 10, 'example 2'],
            [[-3, -1, -2, -4], 10, 'example 3'],
            [[10, 2, 0, 5, 1], 50, 'example 4'],
            [[7, 8, 9, 10, 10], 44, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[4, 3, 2, 1, -6, -7], 40, 'first example from blog'],
            [[5, 3, 2, 1, -6, -7], 41, 'second example from blog'],
            [[3, 2, 1, -5, -6], 28, 'max max, pos min'],
            [[3, 2, -1, -5, -6], 33, 'max max, neg min'],
            [[5, 2, 1, -4, -6], 32, 'min min, pos max'],
            [[5, 2, -1, -6], 28, 'min min, neg max'],
            [[5, 3, 2, 1, -6], 36, 'min min, pos max'],
            [[3, 3, 1, -4, -5], 18, 'min min, pos max, two neg'],
            [[1, 2, 3, 4], 10, 'all pos'],
            [[-1, 2, 3, 4], 14, 'one neg'],
            [[-1, -2, 3, 4], 10, 'two neg'],
            [[-1, -2, -3, 4], 14, 'three neg'],
            [[-1, -2, -3, -4], 10, 'all neg'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
