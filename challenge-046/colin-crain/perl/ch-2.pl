#! /opt/local/bin/perl
#
#       whos_open_for_business.pl
#
#       TASK #2
#         Is the room open?
#             There are 500 rooms in a hotel with 500 employees having keys to all the rooms.
#             The first employee opened main entrance door of all the rooms. The second
#             employee then closed the doors of room numbers 2,4,6,8,10 and so on to 500. The
#             third employee then closed the door if it was opened or opened the door if it
#             was closed of rooms 3,6,9,12,15 and so on to 500. Similarly the fourth employee
#             did the same as the third but only room numbers 4,8,12,16 and so on to 500. This
#             goes on until all employees has had a turn.

#             Write a script to find out all the rooms still open at the end.

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $SIZE = 500;

my @hotel = (0) x $SIZE;

for my $emp (1..$SIZE) {
    my @doors = map { $_ % $emp == 0 ? 1 : 0 } ( 1..$SIZE );
    for my $idx ( 0..$SIZE-1 ) {
        $hotel[$idx] = $hotel[$idx] ^ $doors[$idx];
    }
}

for (0..$SIZE-1) {
   printf "room %3s is open\n", $_+1 if $hotel[$_];
}
