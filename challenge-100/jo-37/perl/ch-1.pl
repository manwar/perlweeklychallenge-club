#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime::Format::DateParse;
use List::Util 'pairs';
use experimental qw(signatures smartmatch);

our ($tests, $examples, $boring);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [-boring] [time]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-boring
    Use a boring DateTime implementation.

time
    A time given as
    - [H]H:MM
    - [I]I:MM[ ]PP
    will be converted to the respectively other format.

EOS


### Input and Output

say $boring ? boring_time($ARGV[0]) : fun_time($ARGV[0]);


### Implementation

# Fun: Dissect and reassemble the time.
#
# * Split time into hours, minutes and an optional period.
# * the hour is adjusted in units of 12h:
#   a) added, if HH == 00             (00:00 -> 12:00 am)
#   b) added, if pm                   (06:00 pm -> 18:00)
#   c) subtracted, if HH > 12         (18:00 -> 06:00 pm)
#   d) subtracted, if HH == 12, am/pm (12:00 am -> 00:00)
#   Notes:
#   - Cases b) and d) cancel each other for 12 pm.
#   - Cases c) and d) can be merged into a single term.
#   - '00' is true, whereas -'00' is not.
#   - smartmatch silently compares undef to a string.
#   - The second argument to sprintf covers all four cases.
# * the minutes are passed unmodified
# * the period is appended if none was given.  Changing the factor in
#   sprintf's fourth argument to 2 produces the alternative output
#   format II:MMPP.
# May produce funny output from funny input, notably 0:00pm -> 24:00.
sub fun_time ($t) {
    $t =~ s{ ^ (\d{1,2}) : (\d{2}) (?:\ ?([ap])m)? $ }
        {sprintf '%02d:%02d%4$*3$.*s',
            $1 + (!-$1 + ($3 ~~ 'p') - ($1 > 11 + !$3)) * 12, $2,
            3 * !$3, qw(am pm)[$1 > 11]}xer;
}

# Boring: Parse and format the time.
sub boring_time ($t) {
    DateTime::Format::DateParse
        ->parse_datetime($t)
        ->strftime($t =~ /[ap]m/ ? '%H:%M' : '%I:%M %P');
}


### Examples and tests

sub run_tests {

    my %time = (fun => \&fun_time, boring => \&boring_time);

    SKIP: {
        skip "examples" unless $examples;

        my %times = (
            'example 1a' => ['05:15 pm', '17:15'],
            'example 1b' => ['05:15pm', '17:15'],
            'example 2'  => ['19:15', '07:15 pm']);

        for my $ex (sort keys %times) {
            is $time{$_}->($times{$ex}[0]), $times{$ex}[1],
                "$ex: $times{$ex}[0] -> $times{$ex}[1], $_" for keys %time;
        }
    }

    SKIP: {
        skip "tests" unless $tests;

        my @times = (
            '12:00 am', '00:00',
            '06:15 am', '06:15',
            '12:30 pm', '12:30',
            '06:45 pm', '18:45');

        for my $times (pairs @times) {
            for my $time ($times, [reverse @$times]) {
                is $time{$_}->($time->[0]), $time->[1],
                    "$time->[0] -> $time->[1], $_" for keys %time;
            }
        }

        # Some extra tests.
        is fun_time('11:59am'), '11:59', 'no space';
        is fun_time('1:11'), '01:11 am', 'one-digit H';
        is fun_time('2:22 pm'), '14:22', 'one-digit I';
        is fun_time('Not A Time'), 'Not A Time', 'Not A Time';

	}

    done_testing;
    exit;
}
