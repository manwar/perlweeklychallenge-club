#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


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
    $0 - scrambled

    usage: $0 [-examples] [-tests] [STR1 STR2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    STR1 STR2
        two strings

    EOS
}


### Input and Output

say 0 + !!are_scrambled(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/24/ch-370.html#task-2


sub scrambled {
    my @x = @_;
    $x[0]->@* == 1 && $x[0][0] eq $x[1][0] && return 1;
    my @ix;
    my $args = sub ($q) {
        map [$x[$_]->@[$ix[$q->[$_]]->@*]], 0, 1
    };
    my $last = $x[0]->$#*;
    for my $i (0 .. $last - 1) {
        @ix = map +([0 .. $_], [$_ + 1 .. $last]), $i, $last - $i - 1;
        p: for my $p ([[0, 0], [1, 1]], [[0, 3], [1, 2]]) {
            __SUB__->($args->($_)) || next p for @$p;
            return 1;
        }
    }
    _:
}

sub are_scrambled ($x, $y) {
    return unless length($x) == length($y);
    scrambled([split //, $x], [split //, $y]);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = are_scrambled(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["abc", "acb"], T(), 'example 1'],
            [["abcd", "cdba"], T(), 'example 2'],
            [["hello", "hiiii"], F(), 'example 3'],
            [["ateer", "eater"], T(), 'example 4'],
            [["abcd", "bdac"], F(), 'example 5'],
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
