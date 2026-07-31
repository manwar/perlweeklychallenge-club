#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @colors = (
    "#F4B2D1",
    "#15E6E5",
    "#191A65",
    "#2D5A1B",
    "#00FF66"
);

print("\n");
foreach my $color (@colors){
    printf(
        "Input: \$color = \"%s\"\nOutput: \"%s\"\n\n",
        $color,
        web_safe_color($color)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a HTML color specification that consists of a six digit hex string (hex
# triplet) with a leading '#' character, determine the nearest web-safe color
# and return a HTML color triplet representing that color; "safe" values for
# each color channel are:
#   Hex     Decimal
#    00           0
#    33          51
#    66         102
#    99         153
#    CC         204
#    FF         255
# Takes one argument:
# * The HTML color to examine (e.g. "#2D5A1B")
# Returns:
# * The nearest web-safe HTML color (e.g. "#336633")
################################################################################
sub web_safe_color{
    # Convert the input hex values into an array
    # of integers
    my @channels = map(
        hex($_),
        unpack(
            "(A2)*",
            substr(shift(), -6)
        )
    );

    my $channel_multiplier;

    # Loop over each channel
    foreach my $channel (@channels){
        # Determine the number that should be
        # multiplied by 51 (the safe color step size)
        # to reach the nearest safe color channel
        # value, and then multiply it by 51 to
        # compute the desired value for this channel
        $channel_multiplier = int($channel / 51);
        $channel_multiplier++
            if($channel % 51 > 25);
        $channel = $channel_multiplier * 51;
    }

    # Convert the channel values into hex codes
    # again and combine into a string
    return(
        "#" . join(
            "",
            map(
                sprintf("%02X", $_),
                @channels
            )
        )
    );

}



