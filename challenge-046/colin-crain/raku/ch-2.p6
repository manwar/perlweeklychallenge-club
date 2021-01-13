use v6.d;

#
#       open-for-business.raku
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

sub MAIN (Int:D $size where {$size > 0} = 500) {

    my @hotel = 0 xx $size;
    for (1..$size) -> $emp {
        my @doors = map { $_ %% $emp ?? 1 !! 0 }, ( 1..$size );
        @hotel = @hotel Z+^ @doors;
    }

    for (0..$size-1) {
        printf "room %3s is open\n", $_+1 if @hotel[$_];
    }

}
