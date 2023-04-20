#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime::Duration;
use DateTime::Format::Strptime;
use List::UtilsBy 'sort_by';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [GUESTBOOK]

-examples
    run the examples from the challenge
 
-tests
    run some tests

GUESTBOOK
    name of guestbook file. Use '-' for STDIN.

EOS


### Input and Output

say light_duration(\*ARGV)->in_units('minutes');


### Implementation

# Converting the guestbook into a list of events.  Each event consists
# of a time and the change in number of guests, i.e. the IN-time with an
# increment of one and the OUT-time with a decrement of one.  Processing
# the events in timed order reveals the number of guests before and
# after each event.  When coming from zero, the switch-on time is
# recorded and when going to zero the swich-on duration is cumulated.

sub light_duration ($fh) {
    my @events;
    my $parser = DateTime::Format::Strptime->new(pattern => '%H:%M');
    # Convert guestbook entries to events.
    while (<$fh>) {
        /^.*?\s+IN:\s*(\d{2}:\d{2})\s+OUT:\s*(\d{2}:\d{2})$/i or next;
        push @events, [$parser->parse_datetime($1), 1],
            [$parser->parse_datetime($2), -1];
    }
    my $light_dur = DateTime::Duration->new;
    my $guests = 0;
    my $starttime;
    # Process events in timed order.
    for my $event (sort_by {$_->[0]} @events) {
        $starttime = $event->[0] unless $guests;
        $guests += $event->[1];
        $light_dur += $event->[0] - $starttime unless $guests;
    }

    $light_dur;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $guestbook = <<EOS;
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
EOS
        open my $fh, '<', \$guestbook;
        is light_duration($fh)->in_units('minutes'), 110, 'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $guestbook = <<EOS;
1) A IN: 09:00 OUT: 10:00
2) B IN: 09:30 OUT: 10:30
3) C IN: 11:00 OUT: 12:00
4) D IN: 11:30 OUT: 12:30
EOS
        open my $fh, '<', \$guestbook;
        is light_duration($fh)->in_units('minutes'), 180, 'two segments';
	}

    done_testing;
    exit;
}
