#!/usr/bin/perl

use strict;
use warnings;

my @rooms = map { 1 } (0..500);
foreach my $employee (2 .. 500) {
    my $room_number = $employee;
    while ($room_number <= 500) {
        $rooms[ $room_number ] = ($rooms [ $room_number ]) ? 0 : 1;
        $room_number += $employee;
    }
}

map { print "$_\n" if $rooms[$_] } (1..500);
