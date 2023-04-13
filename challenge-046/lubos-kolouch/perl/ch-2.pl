#!/usr/bin/perl
use strict;
use warnings;

sub find_open_rooms {
    my $rooms_count = 500;
    my @rooms = (0) x ($rooms_count + 1);

    for (my $i = 1; $i <= $rooms_count; $i++) {
        for (my $j = $i; $j <= $rooms_count; $j += $i) {
            $rooms[$j] = !$rooms[$j];
        }
    }

    my @open_rooms = grep { $rooms[$_] } (1 .. $rooms_count);
    return \@open_rooms;
}

my $open_rooms = find_open_rooms();
print "Open rooms: ", join(", ", @{$open_rooms}), "\n";

