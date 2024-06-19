#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [ "perl",      "e" ],
    [ "java",      "a" ],
    [ "python",    "m" ],
    [ "ada",       "a" ],
    [ "ballerina", "l" ],
    [ "analitik",  "k" ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \$str = \"%s\", \$char = \"%s\"\nOutput: %d\n\n",
        $data_set->[0],
        $data_set->[1],
        character_percentage($data_set->[0], $data_set->[1])
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine what fraction, to the nearest whole percent, of a given string is
# made up of a specified character
# Takes two arguments:
# * The string to examine (e.g. "ballerina")
# * The character to look for within the string (e.g. "l")
# Returns:
# * The percentage of the specified string that is made up of the specified
#   character, rounded to the nearest whole percent (e.g. 22)
################################################################################
sub character_percentage{

    my $percent;
    my $int;

    # Calculate the percentage of the
    # character's appearances in the string
    $percent =
        (
            # See how long a list of only the
            # specifed char is
            scalar(grep($_ eq $ARG[1], split('', $ARG[0])))
            /
            length($ARG[0])
        )
        *
        100;

    # For Perls too old to have POSIX::round, we
    # round appropriately by hand
    $int = int($percent);
    return(
        $percent - $int < 0.5 ?
            $int
            :
            $int + 1
    );

}



