#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/
# Task #2
# Is the room open?
# There are 500 rooms in a hotel with 500 employees having keys to all the rooms.
# The first employee opened main entrance door of all the rooms.
# The second employee then closed the doors of room numbers 2,4,6,8,10 and so on to 500.
# The third employee then closed the door if it was opened or opened the door
# if it was closed of rooms 3,6,9,12,15 and so on to 500.
# Similarly the fourth employee did the same as the third
# but only room numbers 4,8,12,16 and so on to 500.
# This goes on until all employees has had a turn.
#
# Write a script to find out all the rooms still open at the end.

use strict;
use warnings;

use constant MAX => 500;

my @rooms = (-1) x MAX; # all rooms are closed
unshift @rooms, 0;      # add room "0" for simplicity

foreach my $e (1 .. MAX) {
    foreach my $r ($e .. MAX) {
        # change the door status if employee checks that door
        $rooms[$r] *= -1 if ($r % $e == 0);
    }
}

print join ',', grep { $rooms[$_] == 1 } (1 .. MAX);;

__END__
./ch-2.pl
1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,441,484
