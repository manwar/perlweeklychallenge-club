#! /usr/bin/env raku
use v6.d;

# The challenge was silent as to whether zero is allowed in the array.
# If it is, it remains stationary, and can be killed by all other integers
# that collide with it.

my $debug = True;
sub Number-Collision (@battlefield is copy) {
    my $index = 0;
    BATTLE:
    repeat while $index < @battlefield.elems-1 {

        my Int ($fighter-one,          $fighter-two) =
               (@battlefield[$index],  @battlefield[$index+1]);
say "\nBefore: " if $debug;
say "\t$fighter-one vs. $fighter-two" if $debug;
say "\t", @battlefield if $debug;
say "\telems => ", @battlefield.elems if $debug;
say "\tindex => $index" if $debug;
        # if these two adjacent fighters are on the same side,
        # (i.e. they have the same sign), they both survive.  For now.
        # So we move on to the next pair of fighters.
        if $fighter-one.sign == $fighter-two.sign {
say "\t\tNo battle 1" if $debug;
            $index++;
            next BATTLE;
        } # end of if $fighter-one.sign == $fighter-two.sign

        # If the left-most fighter (fighter-one) is negative,
        # then it will not collide with the number to its right.
        # Similarly if the right-most fighter (fighter-two) is posititve,
        # then it will not collide with the number to its left.
        # (The second condition as only necessary
        # if the challenge DOES include zero.)
        if $fighter-one < 0 or $fighter-two > 0 {
say "\t\tNo battle 2" if $debug;
            $index++;
            next BATTLE;
        } # end of if $fighter-one < 0

        if $fighter-one.abs > $fighter-two.abs {
say "\t\t1 wins" if $debug;
            # fighter-two loses!
            @battlefield.splice($index+1, 1);

        } elsif $fighter-two.abs > $fighter-one.abs {
say "\t\t2 wins" if $debug;
            # fighter-one loses!
            @battlefield.splice($index, 1);
            $index-- if $index;

        } else {
say "\t\tThey both lose" if $debug;
            # they both lose!
            @battlefield.splice($index, 2);
            $index-- if $index;

        } # end of if $fighter-one.abs > $fighter-two.abs
say "After: " if $debug;
say "\t$fighter-one vs. $fighter-two" if $debug;
say "\t", @battlefield if $debug;
say "\telems => ", @battlefield.elems if $debug;
say "\tindex => $index" if $debug;
    } # end of repeat until $index ≥ @battlefield.elems

    return @battlefield;
} # end of sub Number-Collision (Int:D @battlefield --> Array[Int])

use Test;

# The first example from the challenge.
is Number-Collision((  2,   3,     -1)),   (  2,  3);
# Test every permutation of positive, negative, and zeros.
is Number-Collision((  2,  -3,      1)),   ( -3,  1);
is Number-Collision(( -2,   3,      1)),   ( -2,  3,  1);
is Number-Collision((  2,  -3,     -1)),   ( -3, -1);
is Number-Collision(( -2,  -3,      1)),   ( -2, -3,  1);
is Number-Collision(( -2,   3,     -1)),   ( -2,  3);
is Number-Collision((  2,   3,      1)),   (  2,  3,  1);
is Number-Collision(( -2,  -3,     -1)),   ( -2, -3, -1);
is Number-Collision((  0,  2,  3, -1)),   (  0,  2,  3   );
is Number-Collision((  0,  2, -3,  1)),   ( -3,  1       );
is Number-Collision((  0, -2,  3,  1)),   ( -2,  3,  1   );
is Number-Collision((  0,  2, -3, -1)),   ( -3, -1       );
is Number-Collision((  0, -2, -3,  1)),   ( -2, -3,  1   );
is Number-Collision((  0, -2,  3, -1)),   ( -2,  3       );
is Number-Collision((  0,  2,  3,  1)),   (  0,  2,  3, 1);
is Number-Collision((  0, -2, -3, -1)),   ( -2, -3, -1   );
is Number-Collision((  2,  0,  3, -1)),   (  2,  3       );
is Number-Collision((  2,  0, -3,  1)),   ( -3,  1       );
is Number-Collision(( -2,  0,  3,  1)),   ( -2,  0,  3, 1);
is Number-Collision((  2,  0, -3, -1)),   ( -3, -1       );
is Number-Collision(( -2,  0, -3,  1)),   ( -2, -3,  1   );
is Number-Collision(( -2,  0,  3, -1)),   ( -2,  0,  3   );
is Number-Collision((  2,  0,  3,  1)),   (  2,  3,  1   );
is Number-Collision(( -2,  0, -3, -1)),   ( -2, -3, -1   );
is Number-Collision((  2,  3,  0, -1)),   (  2,  3       );
is Number-Collision((  2, -3,  0,  1)),   ( -3,  0,  1   );
is Number-Collision(( -2,  3,  0,  1)),   ( -2,  3,  1   );
is Number-Collision((  2, -3,  0, -1)),   ( -3, -1       );
is Number-Collision(( -2, -3,  0,  1)),   ( -2, -3,  0, 1);
is Number-Collision(( -2,  3,  0, -1)),   ( -2,  3       );
is Number-Collision((  2,  3,  0,  1)),   (  2,  3,  1   );
is Number-Collision(( -2, -3,  0, -1)),   ( -2, -3, -1   );
is Number-Collision((  2,  3, -1,  0)),   (  2,  3       );
is Number-Collision((  2, -3,  1,  0)),   ( -3,  1       );
is Number-Collision(( -2,  3,  1,  0)),   ( -2,  3,  1   );
is Number-Collision((  2, -3, -1,  0)),   ( -3, -1,  0   );
is Number-Collision(( -2, -3,  1,  0)),   ( -2, -3,  1   );
is Number-Collision(( -2,  3, -1,  0)),   ( -2,  3       );
is Number-Collision((  2,  3,  1,  0)),   (  2,  3,  1   );
is Number-Collision(( -2, -3, -1,  0)),   ( -2, -3, -1, 0);

# Two more examples from the challenge.
is Number-Collision(( 3, 2, -4)),   ( -4);
is Number-Collision(( 1,    -1)),   ( );

# Try a longer arrray.
is Number-Collision((-2, 5, -7, -10, 4, 5, -7, 10, -8, 6, -2, 6, 6, 7, -2, -1, -2, -8, 4, 10)),
                    (-2, -7, -10, -7, 10, 4, 10);

done-testing;
