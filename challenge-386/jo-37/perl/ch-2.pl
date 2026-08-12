#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use bigrat;


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
    $0 - rational numbers

    usage: $0 [-examples] [-tests] [-verbose] [R1 R2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        print rational numbers as fractions

    R1 R2
        two rational numbers in the format 'III.FFF(PPP)'

    EOS
}


### Input and Output

say +(qw(false true))[equal_rationals(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/14/ch-386.html#task-2

sub to_frac :prototype(_) {
    my ($i, $f, $p) = shift =~ /^(\d*)\.(\d*)(?:\((\d+)\))?$/;
    die "no valid number" unless defined $i;
    my ($en, $eq) = map 10**length, $f, ($p //= 0);
    my $eqd = $eq - 1;
    ($i, $f, $p) = map 0 + ($_ || 0), $i, $f, $p;

    (($i * $en + $f) * $eqd + $p) / ($en * $eqd);
}

sub equal_rationals {
    my ($x, $y) = map to_frac, @_;
    say "$x $y" if $verbose;

    $x == $y;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = equal_rationals(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["0.(12)", "0.(121)"], F(), 'example 1'],
            [["0.1(23)", "0.12(32)"], T(), 'example 2'],
            [["0.1(234)", "0.12(342)"], T(), 'example 3'],
            [["12.99(99)", "13."], T(), 'example 4'],
            [["0.(123)", "0.1(231)"], T(), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is equal_rationals('0.(1234567890)',
            '0.123456789012345678901234567890123456789'), F(),
            'example from blog';
    }) : pass 'skip tests';

    exit;
}
