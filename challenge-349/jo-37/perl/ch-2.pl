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

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - meeting point

    usage: $0 [-examples] [-tests] [-verbose] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say +(qw(false true))[meeting_point(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/28/ch-349.html#task-2

sub meeting_point {
    state $dir = {U => 0, D => 1, R => 2, L => 3};
    state $move = long('1, 0; -1, 0; 0, 1; 0, -1')->xchg(0, 1);
    state $point = long 0, 0;
    my $instr = indx grep defined, $dir->@{split //, shift};

    any eqvec $point, $move($instr)->cumusumover->xchg(0,1);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = meeting_point(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["ULD"], F(), 'example 1'],
            [["ULDR"], T(), 'example 2'],
            [["UUURRRDDD"], F(), 'example 3'],
            [["UURRRDDLLL"], T(), 'example 4'],
            [["RRUULLDDRRUU"], T(), 'example 5'],
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
