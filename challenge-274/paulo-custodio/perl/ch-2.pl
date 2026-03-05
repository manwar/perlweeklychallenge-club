#!/usr/bin/env perl

use Modern::Perl;

my @routes = map {[split ' ', $_]} split /,/, "@ARGV";

say "(", join(', ', skip_minutes(@routes)), ")";

sub skip_minutes {
    my(@routes) = @_;
    my @buses = calc_buses(@routes);
    my @out;
    for (0..59) {
        push @out, $_ if skip_sooner($_, @buses);
    }
    return @out;
}

# build sorted list of [start-time,end-time] for all routes
sub calc_buses {
    my(@routes) = @_;
    my @buses;
    for (@routes) {
        my($interval, $start, $duration) = @$_;
        for (my $time = $start; $time < 120; $time += $interval) {
            push @buses, [$time, $time+$duration];
        }
    }
    return sort {$a->[0] <=> $b->[0]} @buses;
}

# skip bus at this minute to arrive sooner
sub skip_sooner {
    my($minute, @buses) = @_;

    # get first bus that matches
    my($start_time, $end_time);
    for (@buses) {
        my($bus_start, $bus_end) = @$_;
        if ($bus_start >= $minute) {
            ($start_time, $end_time) = ($bus_start, $bus_end);
            last;
        }
    }

    # check if a later bus arrives sooner
    for (@buses) {
        my($bus_start, $bus_end) = @$_;
        return 1 if $bus_start > $start_time && $bus_end < $end_time;
    }

    return 0;
}
