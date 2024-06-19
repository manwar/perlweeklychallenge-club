#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "aabb",
    "abab",
    "aaa",
    "bbb",
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %s\n\n",
        $string,
        b_but_no_following_a($string) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a given string contains at least one 'b', and whether that
# 'b' is NOT followed by an 'a'
# Takes one argument:
# * The string to examine (e.g. "aaaba")
# Returns:
# * True if there is at least one 'b' in the string, which is NOT followed by
#   any instance of an 'a'
# * False if there are no instances of a 'b' in the string, or if there are, 
#   they are followed by an instance of an 'a' (as would be the case in the
#   example above)
################################################################################
sub b_but_no_following_a{

    return(
        # There must be a 'b'
        $ARG[0] =~ m/b/g
        &&
        # And there must NOT be an 'a' after the
        # 'b'
        $ARG[0] !~ m/\Ga/g
    );

}



