#! /usr/bin/env raku
use v6.d;

# The challenge was silent as to whether zero is allowed in the array.
# If it is, it remains stationary, and can be killed
# by all other integers that collide with it.

sub Number-Collision (@battlefield is copy) {
    my $index = 0;
    BATTLE:
    repeat while $index < @battlefield.elems-1 {
        my Int ($fighter-one,          $fighter-two) =
               (@battlefield[$index],  @battlefield[$index+1]);

        # If these two adjacent fighters are on the same side,
        # (i.e. they have the same sign), they both survive.  For now.
        # So we move on to the next pair of fighters.
        if $fighter-one.sign == $fighter-two.sign {
            $index++;
            next BATTLE;
        } # end of if $fighter-one.sign == $fighter-two.sign

        # If the left-most fighter (fighter-one) is negative,
        # then it will not collide with the number to its right.
        # Similarly if the right-most fighter (fighter-two) is posititve,
        # then it will not collide with the number to its left.
        # So we move on to the next pair of fighters.
        # (The second condition is only necessary
        # if the challenge DOES include zero.)
        if $fighter-one < 0 or $fighter-two > 0 {
            $index++;
            next BATTLE;
        } # end of if $fighter-one < 0

        if $fighter-one.abs > $fighter-two.abs {
            # fighter-two loses!
            @battlefield.splice($index+1, 1);

        } elsif $fighter-two.abs > $fighter-one.abs {
            # fighter-one loses!
            @battlefield.splice($index, 1);
            $index-- if $index;

        } else {
            # they both lose!
            @battlefield.splice($index, 2);
            $index-- if $index;

        }
    } # end of repeat until $index ≥ @battlefield.elems

    return @battlefield;
} # end of sub Number-Collision (Int:D @battlefield --> Array[Int])

use Test;

# The examples from the challenge.
is Number-Collision(( 2, 3, -1)), ( 2,  3);
is Number-Collision(( 3, 2, -4)), (-4);
is Number-Collision(( 1,    -1)), ();

# Test every permutation of positive, negative, and zeros.
is Number-Collision((  2,  -3,      1)), ( -3,  1       );
is Number-Collision(( -2,   3,      1)), ( -2,  3,  1   );
is Number-Collision((  2,  -3,     -1)), ( -3, -1       );
is Number-Collision(( -2,  -3,      1)), ( -2, -3,  1   );
is Number-Collision(( -2,   3,     -1)), ( -2,  3       );
is Number-Collision((  2,   3,      1)), (  2,  3,  1   );
is Number-Collision(( -2,  -3,     -1)), ( -2, -3, -1   );
is Number-Collision((  0,   2,  3, -1)), (  0,  2,  3   );
is Number-Collision((  0,   2, -3,  1)), ( -3,  1       );
is Number-Collision((  0,  -2,  3,  1)), ( -2,  3,  1   );
is Number-Collision((  0,   2, -3, -1)), ( -3, -1       );
is Number-Collision((  0,  -2, -3,  1)), ( -2, -3,  1   );
is Number-Collision((  0,  -2,  3, -1)), ( -2,  3       );
is Number-Collision((  0,   2,  3,  1)), (  0,  2,  3, 1);
is Number-Collision((  0,  -2, -3, -1)), ( -2, -3, -1   );
is Number-Collision((  2,   0,  3, -1)), (  2,  3       );
is Number-Collision((  2,   0, -3,  1)), ( -3,  1       );
is Number-Collision(( -2,   0,  3,  1)), ( -2,  0,  3, 1);
is Number-Collision((  2,   0, -3, -1)), ( -3, -1       );
is Number-Collision(( -2,   0, -3,  1)), ( -2, -3,  1   );
is Number-Collision(( -2,   0,  3, -1)), ( -2,  0,  3   );
is Number-Collision((  2,   0,  3,  1)), (  2,  3,  1   );
is Number-Collision(( -2,   0, -3, -1)), ( -2, -3, -1   );
is Number-Collision((  2,   3,  0, -1)), (  2,  3       );
is Number-Collision((  2,  -3,  0,  1)), ( -3,  0,  1   );
is Number-Collision(( -2,   3,  0,  1)), ( -2,  3,  1   );
is Number-Collision((  2,  -3,  0, -1)), ( -3, -1       );
is Number-Collision(( -2,  -3,  0,  1)), ( -2, -3,  0, 1);
is Number-Collision(( -2,   3,  0, -1)), ( -2,  3       );
is Number-Collision((  2,   3,  0,  1)), (  2,  3,  1   );
is Number-Collision(( -2,  -3,  0, -1)), ( -2, -3, -1   );
is Number-Collision((  2,   3, -1,  0)), (  2,  3       );
is Number-Collision((  2,  -3,  1,  0)), ( -3,  1       );
is Number-Collision(( -2,   3,  1,  0)), ( -2,  3,  1   );
is Number-Collision((  2,  -3, -1,  0)), ( -3, -1,  0   );
is Number-Collision(( -2,  -3,  1,  0)), ( -2, -3,  1   );
is Number-Collision(( -2,   3, -1,  0)), ( -2,  3       );
is Number-Collision((  2,   3,  1,  0)), (  2,  3,  1   );
is Number-Collision(( -2,  -3, -1,  0)), ( -2, -3, -1, 0);

# Some more examples where they all die.
is Number-Collision(( 1, 2, -2, -1)), ( );
is Number-Collision(( 2, 1, -1, -2)), ( );
is Number-Collision(( 2, 1,  1, -2)), ( );


# Try a longer arrray.
is Number-Collision((-2, 5, -7, -10, 4, 5, -7, 10, -8, 6, -2, 6, 6, 7, -2, -1, -2, -8, 4, 10)),
                    (-2, -7, -10, -7, 10, 4, 10);

done-testing;
