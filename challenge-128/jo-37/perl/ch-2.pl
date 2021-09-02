#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'reduce';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [arrivals departures]

-examples
    run the examples from the challenge
 
-tests
    run some tests

arrivals
    comma and/or space separated list of arrivals, e.g.
    '11:20, 14:30'

departures
    comma and/or space separated list of departures, e.g.
    '11:50, 15:00'

EOS


### Input and Output

say platforms(map [split /[,\s]\s*/, $_], @ARGV);


### Implementation

# Unwinding from behind and outwards:
# - Convert the arrival and departure arrays to AoAs holding the time
#   and train delta (arrivals: +1, departures: -1).
# - Remove the colon from [H]H:MM to gain numeric comparability.
# - Sort/merge the arrival/departure lists by time and event.  Presuming
#   arrivals to occur before simultaneous departures and thus forbidding
#   the usage of the same platform for such.
# - Count the current and maximum number of present trains at each
#   event.
# - The first element of the reduce result is the maximum number of
#   simultaneously present trains and therefore the requested minimum
#   number of required platforms.
sub platforms ($arrivals, $departures) {
    (reduce {[$a->[($a->[1] += $b->[1]) > $a->[0]], $a->[1]]}
        ['-inf', 0], sort {$a->[0] <=> $b->[0] || $b->[1] <=> $a->[1]}
        map {$_->[0] =~ tr/://d; $_}
        map([$_, 1], @$arrivals), map([$_, -1], @$departures))->[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is platforms([qw(11:20 14:30)], [qw(11:50 15:00)]), 1, 'example 1';
        is platforms([qw(10:20 11:00 11:10 12:20 16:20 19:00)],
            [qw(10:30 13:20 12:40 12:50 20:20 21:20)]), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is platforms([qw(9:30 10:00)], [qw(10:15 10:30)]), 2, 'one digit hour';
        is platforms([qw(09:30 10:00)], [qw(10:15 10:30)]), 2, 'leading zero';
        is platforms([qw(1:00 1:10)], [qw(1:10 1:20)]), 2,
            'no simultaneous arrival and departure at the same platform';
	}

    done_testing;
    exit;
}
