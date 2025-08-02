#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "pPeERrLl",
    "rRr",
    "GoO"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = '%s'\nOuput: %d\n\n",
        $string,
        count_key_changes($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an alphabetic string, determine the number of times the user who typed
# it had to change keys on their keyboard- not counting shift or caps lock- to
# input it
# Takes one argument:
# * The string to examine (e.g. "pPeERrLl")
# Returns:
# * The number of key changes requires to input the string (e.g. 3 )
################################################################################
sub count_key_changes{

    my @chars = split(//, lc(shift()));
    my $changes = 0;

    # Loop over each lower-cased character
    foreach my $i (1 .. $#chars){
        # Increment the change count if this character
        # differs from the previous one
        $changes++
            unless($chars[$i - 1] eq $chars[$i]);
    }

    return($changes);

}



