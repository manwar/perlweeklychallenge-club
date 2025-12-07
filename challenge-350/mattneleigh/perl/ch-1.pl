#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "abcaefg",
    "xyzzabc",
    "aababc",
    "qwerty",
    "zzzaaa"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        count_good_substrings($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, count the number of Good Strings of length three appear
# within, where a Good String is defined as one in which there are no
# duplicated characters
# Takes one argument:
# * The string to examine (e.g. "aababc")
# Returns:
# * The number of Good Strings observed within the supplied string (e.g. 1)
################################################################################
sub count_good_substrings{
    my $string = shift();

    my $goodct = 0;

    for my $i (0 .. length($string) - 3){
        # Count up the three letter strings that match our search
        # criteria; using substr() to cut up the string for scanning is
        # faster than moving the rexex around within the full string
        # using pos() and \G, oddly enough
        $goodct++
            if(substr($string, $i, 3) =~ m/^(.)(?!\1)(.)(?!\1|\2)/);
    }

    return($goodct);

}



