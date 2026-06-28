#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "",
    "reverse the given string",
    "Perl is Awesome",
    "v1.0.0-Beta!",
    "racecar"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        nonstandard_reverse($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Reverse the order in which characters in a string appear, without using the
# standard reverse() function
# Takes one argument:
# * The string to reverse (e.g. "Perl is Awesome")
# Returns:
# * The reversed string (e.g. "emosewA si lreP")
################################################################################
sub nonstandard_reverse{
    my $string = shift();

    my $reversed = "";

    for my $pos (1 .. length($string)){
        $reversed .= substr($string, -$pos, 1);
    }

    return($reversed);

}



