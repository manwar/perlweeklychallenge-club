#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 2, 3, -1 ],
    [ 3, 2, -4 ],
    [ 1, -1 ],

    # Additional test cases
    [ -3, 2 ],
    [ 1, 0, 4, -1, 2, -3, 3 ],
    [ 10, 1, 3, 3, 4, 5, 6, 7, 8, -9 ]
);

print("\n");
foreach my $list (@integer_lists){
    printf(
        "Input: \@list = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$list}),
        join(", ", move_and_collide(@{$list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers, move positive ones to the right, and negative ones
# to the left.  Where integers heading in opposite directions meet, they will
# collide and the one with the larger absolute value will survive; if both have
# the same absolute value, both will be destroyed.
# Takes one argument:
# * A list of integers to process
# Returns
# * The list of integers after all movement and collisions are resolved
################################################################################
sub move_and_collide{

    my $collision = 1;

    while($collision){
        my $i = 0;

        $collision = 0;
        while($i < $#ARG){
            if($ARG[$i + 1] < 0){
                # The next number wants to move
                # left
                if(abs($ARG[$i]) < abs($ARG[$i + 1])){
                    # The current number explodes
                    splice(@ARG, $i, 1);
                } elsif(abs($ARG[$i]) > abs($ARG[$i + 1])){
                    # The next number explodes
                    splice(@ARG, $i + 1, 1);
                } else{
                    # Both explode
                    splice(@ARG, $i, 2);
                }

                $collision = 1;
            } else{
                # No collision- move on to the next
                # number
                $i++;
            }
        }
    }

    return(@ARG);

}



