#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental qw(signatures);


### Options and Arguments

my ($tests, $examples, $verbose);

GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();


run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 3;

sub usage {
    die <<~EOS;
    $0 - shuffle pairs

    usage: $0 [-examples] [-tests] [-verbose] [FROM TO COUNT]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        list all found pairs instead of the count

    FROM TO COUNT
        as described in the task text

    EOS
}


### Input and Output

if ($verbose) {
    say "$_->[0]: ($_->[1]->@*)" for shuffle_pairs(@ARGV);
} else {
    say scalar shuffle_pairs(@ARGV);
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/12/05/ch-350.html#task-2

sub shuffle_pairs ($from, $to, $count) {
    my @pairs;
    for my $i ($from .. $to) {
        my $si = join '', sort split //, $i;
        my $m = int +(10**(int(log($i)/log(10)) + 1) - 1) / $i;
        my @pals =
            grep $si eq join('', sort split //, $_),
            map $_ * $i,
            2 .. $m;
        push @pairs, [$i, \@pals] if @pals >= $count;
    }
    @pairs;
}

sub shuffle_pairs_q ($from, $to, $count) {
    my $pairs;
    for my $i ($from .. $to) {
        my $si = join '', sort split //, $i;
        my $m = int +(10**(int(log($i)/log(10)) + 1) - 1) / $i;
        $pairs +=
            $count <= grep $si eq join('', sort split //, $_),
            map $_ * $i,
            2 .. $m;
    }
    $pairs;
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = shuffle_pairs(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 1000, 1], 0, 'example 1'],
            [[1500, 2500, 1], 3, 'example 2'],
            [[1e6, 1.5e6, 5], 2, 'example 3'],
            [[13_427_000, 14_100_000, 2], 11, 'example 4'],
            [[1030, 1130, 1], 2, 'example 5'],
             
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
