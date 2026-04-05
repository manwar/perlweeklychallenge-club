#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub hm2m($t) {
    # Convert a HH:MM formatted string to minutes since midnight
    if ($t !~ /^([0-1][0-9]|2[0-3]):[0-5][0-9]$/) {
        die "Input is not in the expected format (HH:MM)\n";
    }

    return substr($t,0,2) * 60 + substr($t,3,2);
}

sub main (@times) {
    # Group pairs of times from command line
    my @events = ();
    for (my $i = 0; $i <= $#ARGV; $i+=2) {
        push @events, [ $times[$i], $times[$i+1]];
    }
    my @event_minutes = ();
    foreach my $event (@events) {
        # Convert times into minutes since midnight
        my $start_minute = hm2m($event->[0]);
        my $end_minute = hm2m($event->[1]);
        if ($start_minute == $end_minute) {
            # There is no intersection of a single point in time
            next;
        }

        if ($end_minute < $start_minute) {
            # Time spans midnight
            push @event_minutes, [$start_minute, 1440], [0, $end_minute];
        }
        else {
            push @event_minutes, [$start_minute, $end_minute];
        }
    }

    # Check if any minutes overlap
    my %minutes = ();
    foreach my $r (@event_minutes) {
        foreach my $minute ($r->[0] .. $r->[1] - 1) {
            if (exists $minutes{$minute}) {
                # A minute appears in more than one range.
                say "true";
                return;
            }
            $minutes{$minute} = undef;
        }}

    # No conflicts found. Woohoo!
    say "false";
}

main(@ARGV);