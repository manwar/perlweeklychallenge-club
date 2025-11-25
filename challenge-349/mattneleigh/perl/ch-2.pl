#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @instruction_sets = (
    "ULD",
    "ULDR",
    "UUURRRDDD",
    "UURRRDDLLL",
    "RRUULLDDRRUU"
);

print("\n");
foreach my $instruction_set (@instruction_sets){
    printf(
        "Input: \$path = \"%s\"\nOutput: %s\n\n",
        $instruction_set,
        path_crosses_origin($instruction_set) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of movement instructions, consisting of:
# * U for up
# * D for down
# * R for right
# * L for left
# determine whether the path traced by these instructions passes through the
# origin point; note that the path does NOT have to end at the origin point for
# this condition to be met, it merely has to pass through it
# Takes one argument:
# * The string of instructions to follow (e.g. "RRUULLDDRRUU")
# Returns:
# * 0 if the path traced by the provided instructions does NOT pass through the
#   starting point
# * 1 if the path traced by the provided instructions passes through the
#   starting point (as it would in the example above- though the path does not
#   end there)
################################################################################
sub path_crosses_origin{

    my $x = 0;
    my $y = 0;

    # Loop over every provided instruction, incrementing
    # or decrementing the vertical (y) and horizontal (x)
    # coordinate accordingly
    foreach my $instruction (split("", shift())){
        if($instruction eq "U"){
            $y++;
        } elsif($instruction eq "D"){
            $y--;
        } elsif($instruction eq "R"){
            $x++;
        } elsif($instruction eq "L"){
            $x--;
        }

        # If the current point is the origin, return
        # true
        return(1)
            if(($x == 0) && ($y == 0));
    }

    # Never saw the origin; return false
    return(0);

}



