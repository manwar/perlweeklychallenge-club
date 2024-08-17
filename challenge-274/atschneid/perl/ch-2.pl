use strict;
use warnings;

use v5.38;


my @scheds = (
    [
     [12, 11, 41],
     [15, 5, 35]
    ],
    [
     [12, 3, 41],
     [15, 9, 35],
     [30, 5, 25]
    ]
    );
for (@scheds) {
    say join ", ", find_switch_minutes( @$_ );
}


sub find_switch_minutes( @schedules ) {
    my $num_minutes = 60;
    
    my %next_depart;
    my %next_arrive;

    for my $s (@schedules) {
        my ($step, $start, $duration) = @$s;
	
        my @temp_vals = (-1) x ($num_minutes + $start + 1);
	for (my $i = $start; $i < $num_minutes + $start + 1; $i+=$step) {
            $temp_vals[$i] = [$i + $duration, $i];
	}
	
	# this is to backfill for the next arrival
        my $fill_val = -1;
	for (my $i = $#temp_vals; $i > -1; --$i) {
            if ($temp_vals[$i] != -1) {
                $fill_val = $temp_vals[$i];
	    } else {
                $temp_vals[$i] = $fill_val;
	    }
	}

	# now find the minimum for arrival time and minimum for departure time
	for my $i (0..$#temp_vals) {
	    my $val = $temp_vals[$i];

            if ($val == -1) {
		last;
	    }

            if (not exists $next_depart{$i} or $val->[1] < $next_depart{$i}->[1]) {
                $next_depart{$i} = $val;
	    } elsif ($val->[1] == $next_depart{$i}->[1] and $val->[0] < $next_arrive{$i}->[0]) {
                $next_depart{$i} = $val;
	    }
	    
            if (not exists $next_arrive{$i} or $val->[0] < $next_arrive{$i}->[0]) {
                $next_arrive{$i} = $val;
	    }
        }
    }

    # now check if any earliest leave time isn't an earliest arrive time
    my @indices;
    for my $i (0..$num_minutes-1) {
        if (not exists $next_arrive{$i} or not exists $next_depart{$i}) {
            next;
	}
        if ($next_arrive{$i}->[0] < $next_depart{$i}->[0]) {
            push @indices, $i;
	}
    }

    return @indices;
}
