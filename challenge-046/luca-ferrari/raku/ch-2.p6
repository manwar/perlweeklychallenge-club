#!env perl6

# Perl Weekly Challenge 46
#
# Task 2
# There are 500 rooms in a hotel with 500 employees having keys to all the rooms.
# The first employee opened main entrance door of all the rooms.
# The second employee then closed the doors of room numbers 2,4,6,8,10 and so on to 500.
# The third employee then closed the door if it was opened or opened the door if it was closed
# of rooms 3,6,9,12,15 and so on to 500.
# Similarly the fourth employee did the same as the third but only
# room numbers 4,8,12,16 and so on to 500.
# This goes on until all employees has had a turn.
# Write a script to find out all the rooms still open at the end.
#
# Possible output:
# % perl6 ch-2.p6
#   Room 1 is Open
#   Room 4 is Open
#   Room 9 is Open
#   Room 16 is Open
#   Room 25 is Open
#   Room 36 is Open
#   Room 49 is Open
#   Room 64 is Open
#   Room 81 is Open
#   Room 100 is Open
#   Room 121 is Open
#   Room 144 is Open
#   Room 169 is Open
#   Room 196 is Open
#   Room 225 is Open
#   Room 256 is Open
#   Room 289 is Open
#   Room 324 is Open
#   Room 361 is Open
#   Room 400 is Open
#   Room 441 is Open
#   Room 484 is Open




sub MAIN( Int :$room-count = 500 ) {

    # create an hash with the rooms, the False status means they are closed,
    # while the True means they are open
    my %rooms = ( 1 .. $room-count).map: * => False;

    # every employee flips the status
    for 1 .. $room-count -> $employee {
        %rooms{ $_ } = ! %rooms{ $_ } if $_ %% $employee for 1 .. $room-count;
    }

    # now print out all the opened rooms
    say "Room $_ is Open" if %rooms{ $_ } for %rooms.keys.sort: *.Int <=> *.Int;

}
