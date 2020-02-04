#!/usr/bin/env perl6

# @doors will be an array of 0s and 1s.
# A 0 will be an open door and a 1 will be a closed door.
# Employee 1 opens all doors.
my @doors[500] = 0 xx 500;

for 2..500 -> $emp {
    # @seq will hold the door numbers that 
    # the current employee will open/close.
    my @seq = $emp, $emp*2...500;

    for @seq -> $door {
        # If the door is open then close it.
        # If the door is closed then open it.
        # The "+^= 1" will toggle the number.
        @doors[$door-1] +^= 1;
    }
}

for 1..500 -> $door {
    # Print the door number if it is open.
    say $door unless @doors[$door-1];
}
