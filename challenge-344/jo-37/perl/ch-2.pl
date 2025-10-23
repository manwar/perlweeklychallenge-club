#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use Data::Dump;

use List::MoreUtils 'frequency';


### Options and Arguments

my ($tests, $examples, $verbose, $target);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'target=s'  => \$target,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless defined $target && @ARGV;

sub usage {
    die <<~EOS;
    $0 - Task Title

    usage: $0 [-examples] [-tests] [-verbose] [--] [-target T,... S...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    -target T,...
        list of space and/or comma separated integers

    S...
        list of integer arrays, each consisting of space and/or comma
        separated numbers

    EOS
}


### Input and Output

say +(qw(true false))[!array_formation([map [split /[\s,]\s*/], @ARGV], [split /[\s,]\s*/, $target])];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/23/ch-344.html#task-2

sub array_formation ($source, $target) {
    array_formation_r(map join("\cG", @$_, ''), $target, @$source);
}

sub array_formation_r ($target, @source) {
    !@source && return !$target;
    my (@done, %seen);
    while (defined (my $source = shift @source)) {
        $seen{$source}++ && next;
        my $match = (my $tail = $target) =~ s/^\Q$source//;
        !@source && !@done && return $match && !$tail;
        $match && array_formation_r($tail, @done, @source) && return 1;
    } continue {
        push @done, $source;
    }
    _:
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
    {
        my $todo;
        $todo = todo $reason if $reason;
        my $result = array_formation(@$args);
        is $result, $expected,
            "$name: (@{[map qq{[@$_]}, $args->[0]->@*]}, [$args->[1]->@*]) -> " . $expected->name;
    }}

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[[2,3], [1], [4]], [1, 2, 3, 4]], T(), 'example 1'],
            [[[[1,3], [2,4]], [1, 2, 3, 4]], F(), 'example 2'],
            [[[[9,1], [5,8], [2]], [5, 8, 2, 9, 1]], T(), 'example 3'],
            [[[[1], [3]], [1, 2, 3]], F(), 'example 4'],
            [[[[4, 7, 6]], [4, 7, 6]], T(), 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my $n = 10;
        my @tests = (
            [[[[1,2,3], [4, 5]], [1, 2, 3, 4, 5, 6]], F(), 'target too long'],
            [[[], [1]], F(), 'empty source'],
            [[[], []], T(), 'empty source and target'],
            [[[[1,2,3], [3, 4], [1, 2]], [1, 2, 3, 3, 4, 1, 2]], T(),
                'pick first'],
            [[[[1,2,3], [3, 4], [1, 2]], [1, 2, 3, 4, 1, 2, 3]], T(),
                'pick second'],
            [[[[qw(ab cd)], [qw(ac bd)]], [qw(ac bd ab cd)]], T(),
                'match strings, true'],
            [[[[qw(ab cd)], [qw(ac bd)]], [qw(ab ac cd bd)]], F(),
                'match strings, false'],
            [[[[(".*") x 4]], [qw(ab ac cd bd)]], F(),
                'do not match meta chars'],
            [[[[qw(ab cd)], [qw(ac bd)]], [qw(ab ac cd bd)]], F(),
                'match strings, false'],
            [[[["a"], ["b"], ["c\cGd"]], ["a\cGb", "c", "d"]], F(),
                'abusing the separator', 'should fail'],
            [[[([1,1]) x $n , [1, 2]], [(1, 1) x $n, 2, 1]], F(), 'fail faster'],
            [[[([1,1]) x $n , [1, 2]], [(1, 1) x $n, 1, 2]], T(), 'cross check'],
            [[[[2], [], [1]], [1, 2]], T(), 'empty source element'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
