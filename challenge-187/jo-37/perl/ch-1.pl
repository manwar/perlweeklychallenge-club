#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime;
use List::Util qw(min max);
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [SCHEDULE]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SCHEDULE
    A trip schedule as given in the examples.  Entries have the form
    <name> => <key1>: '<value1>'...
    where <name> and <keyN> can be any word and <valueN> is any string
    not containing a single quote.  There shall be keys 'SD' and 'ED'
    for every entry with values in the form 'DD-MM' specifying a day and
    month, e.g.
    $0 "Foo => SD: '12-01' ED: '20-01'" "Bar => SD: '15-01' ED: '18-01'"

EOS


### Input and Output

main: {
    my $days_together = days_together(parse_schedule(join ' ', @ARGV));
    printf "%d day%.*s\n", $days_together, $days_together != 1, 's';
}


### Implementation

# Splitting this task into two:
# 1) Parse a string representing a "schedule" as given in the examples
#    into a HoH.
# 2) Find the number of common days that the friends stay together on
#    their holidays based on the given schedule.
#
# Neither the parsing, nor the calculation of the "days together" are
# restricted to only two traveling friends.

# Parse a string into a HoH: Keys to the outer hash are "words" followed
# by '=>'. The inner hashes are "word" keys followed by a colon and a
# singly quoted value.
sub parse_schedule {
    local $_ = shift;
    my %schedule;
    while (/\G\s*(\w+)\s*=>/g) {
        my $friend = $1;
        $schedule{$friend}{$1} = $2 while /\G\s*(\w+):\s*'([^']*)'/gc;
    }
    \%schedule;
}

# Taking the duration between the latest start date and the earliest end
# date almost gives the requested "days together".  Just need to add one
# day as both dates are inclusive and turn negative durations to zero. 
sub days_together ($schedule) {
    my $common =
    (min(get_dates($schedule, 'ED')) - max(get_dates($schedule, 'SD')))
        ->in_units('days');

    ($common >= 0) * ($common + 1);
}

# Pick values from the inner hash for a given key and create DateTime
# objects for the given day/month in year 1, which is not a leap year.
sub get_dates ($schedule, $type) {
    map {
        (\my %date)->@{qw(year day month)} = (1, split /-/, $_->{$type});
        DateTime->new(%date);
    } values %$schedule;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is days_together({Foo => {SD => '12-01', ED => '20-01'},
            Bar => {SD => '15-01', ED => '18-01'}}), 4, 'example 1';

        is days_together({Foo => {SD => '02-03', ED => '12-03'},
            Bar => {SD => '13-03', ED => '14-03'}}), 0, 'example 2';

        is days_together({Foo => {SD => '02-03', ED => '12-03'},
            Bar => {SD => '11-03', ED => '15-03'}}), 2, 'example 3';

        is days_together({Foo => {SD => '30-03', ED => '05-04'},
            Bar => {SD => '28-03', ED => '02-04'}}), 4, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is days_together({Foo => {SD => '27-02', ED => '01-03'},
            Bar => {SD => '28-02', ED => '02-03'}}), 2, 'not a leap year';

        is days_together({A => {SD => '01-06', ED => '06-06'},
                B => {SD => '02-06', ED => '07-06'},
                C => {SD => '03-06', ED => '08-06'}}), 4, 'three friends';
    
        is parse_schedule("A => A1: 'va1' A2: 'va2' B => B1: 'vb1' B2: 'vb2'"),
            {A => {A1 => 'va1', A2 => 'va2'}, B => {B1 => 'vb1', B2 => 'vb2'}},
            'parse HoH';
	}

    done_testing;
    exit;
}
