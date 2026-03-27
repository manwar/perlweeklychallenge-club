#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use List::Util 'reduce';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - valid times

    usage: $0 [-examples] [-tests] [TIME]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    TIME
        a time string in HH:MM format that may contain question marks
        instead of digits

    EOS
}


### Input and Output

say valid_times(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/27/ch-366.html#task-2

BEGIN {
    my @count_pos = (
        sub (@time) {$time[0] < 0 && $time[1] < 0  ? 24 :
                     $time[0] < 2 && $time[1] < 0  ? 10 :
                                     $time[1] < 0  ?  4 :
                     $time[0] < 0 && $time[1] < 4  ?  3 :
                     $time[0] < 0                  ?  2 :
                     10 * $time[0] + $time[1] < 24 ?  1 : 0},
        sub (@time) {$time[2] < 0                  ?  6 : 1},
        sub (@time) {$time[3] < 0                  ? 10 : 1},
    );

    sub valid_times ($time) {
        my @time = map $_ eq '?' ? -1 : $_,
            $time =~ /^([0-2?])([0-9?]):([0-5?])([0-9?])$/ or return 0;
        reduce {$a * $b->(@time)} 1, @count_pos;
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = valid_times(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["?2:34"],    3, 'example 1'],
            [["?4:?0"],   12, 'example 2'],
            [["??:??"], 1440, 'example 3'],
            [["?3:45"],    3, 'example 4'],
            [["2?:15"],    4, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["00:00"],    1, 'first valid'],
            [["23:59"],    1, 'last valid'],
            [["24:00"],    0, 'first invalid'],
            [["4?:??"],    0, 'invalid first'],
            [["25:??"],    0, 'invalid second'],
            [["??:70"],    0, 'invalid third'],
            [["??:5O"],    0, 'invalid fourth'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
