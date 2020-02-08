#!/usr/bin/env perl6

my $open := True;

# @doors is an array of Bools.
# The first employee opens every door.
my @doors = $open xx 500;

for 2 .. 500 -> $emp {
    # The following sequence is the doors that 
    # the next employee opens or closes.
    for $emp, $emp*2 ... 500 -> $door {
        # If the door is open then close it.
        # If the door is closed then open it.
        # The "?^= $open" will toggle the Bool.
        @doors[$door-1] ?^= $open;
    }
}

for 1 .. 500 -> $door {
    # Print the door if it's open.
    say $door if @doors[$door-1];
}
