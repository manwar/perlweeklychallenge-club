#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
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

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - who wins

    usage: $0 [-examples] [-tests] [RES]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    RES
        string of six 'H's or 'A's representing the winners

    EOS
}


### Input and Output

printf "Team %d defeated Team %d\n", who_wins(shift)->list;


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/16/ch-356.html#task-2

sub who_wins {
    my $result = long 0, split //, shift =~ tr/HA/01/r;
    state $week1 = long [1, 1], [2, 7], [3, 6], [4, 5];
    state $iweek2 = long [0, 3], [1, 2];
    my $s1 = cat(sequence(4), $result(0:3))->xchg(0, 1);
    my $s2 = cat(sequence(2), $result(4:5))->xchg(0, 1);
    my $s3 = $result(6) ? indx(1, 0) : indx(0, 1);

    $week1->xchg(0, 1)->indexND($s1)->qsort->index1d($iweek2)->xchg(0, 1)
        ->indexND($s2)->qsort->index1d($s3);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = who_wins(@$args);
        pdl_is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["HAHAHH"], long(2, 6), 'example 1'],
            [["HHHHHH"], long(1, 2), 'example 2'],
            [["HHHAHA"], long(4, 2), 'example 3'],
            [["HAHAAH"], long(4, 6), 'example 4'],
            [["HAAHAA"], long(5, 1), 'example 5'],
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
