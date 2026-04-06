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
    $0 - conflict events

    usage: $0 [-examples] [-tests] [EVENT1 EVENT2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    EVENT1 EVENT2
        two events in the form HS:MS,HE:ME specifying start and end times

    EOS
}


### Input and Output

say +(qw(true false))[!conflict_events(map [split /[,\s]+/], @ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/02/ch-367.html#task-2

sub dur ($event) {
    ($event->[1] - $event->[0]) % (24 * 60) || 24 * 60;
}

sub conflict_events ($event1, $event2) {
    my @events =  
        map [map {
                my ($h, $m) = split /:/;
                (60 * $h + $m) % (24 * 60);
            } @$_
        ], $event1, $event2;

        dur($events[0]) + dur($events[1]) > dur([$events[0][0], $events[1][1]]);
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = conflict_events(@$args);
        is $result, $expected,
            qq{$name: (@{[map "@$_", @$args]}) -> } . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[["10:00", "12:00"], ["11:00", "13:00"]], T(), 'example 1'],
            [[["09:00", "10:30"], ["10:30", "12:00"]], F(), 'example 2'],
            [[["14:00", "15:30"], ["14:30", "16:00"]], T(), 'example 3'],
            [[["08:00", "09:00"], ["09:01", "10:00"]], F(), 'example 3'],
            [[["23:30", "00:30"], ["00:00", "01:00"]], T(), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[["00:00", "12:00"], ["12:00", "00:00"]], F(), 'whole day'],
            [[["00:00", "11:59"], ["12:00", "23:59"]], F(), 'almost whole day'],
            [[["00:00", "00:00"], ["00:00", "00:01"]], T(), 'whole day #2'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
