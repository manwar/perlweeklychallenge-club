#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings_and_characters = (
    # Given cases
    [ "loveleetcode", "e" ],
    [ "aaab",         "b" ],

    # Additional test cases
    [ "perliscool",   "x" ]
);

print("\n");
foreach my $string_and_character (@strings_and_characters){
    printf(
        "Input: \$str = \"%s\", \$char = \"%s\"\nOutput: (%s)\n\n",
        @{$string_and_character},
        join(
            ", ",
            relative_distances_to_character(@{$string_and_character})
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string and a character, calculate the relative distance from each
# character within the string to the nearest match of the specified character,
# if found
# Takes two arguments:
# * A string to examine (e.g. "loveleetcode")
# * A character to look for in the string (e.g. 'e')
# Returns on success:
# * A list of relative distances from each position in the string to the
#   nearest match to the specified character (e.g.
#   (3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0) )
# Returns on error:
# * The empty list (i.e. () ) if the specified character is not found within
#   the string
################################################################################
sub relative_distances_to_character{
    # Required for @LAST_MATCH_START (@-)
    use v5.6;
    use List::Util qw(min);

    my @matches;
    my $current = 0;

    # Attempt to match the character in the
    # string, taking note of the location of
    # each occurrence
    while($ARG[0] =~ m/$ARG[1]/g){
        push(@matches, $LAST_MATCH_START[0]);
    }

    # Return an empty list if the character
    # wasn't found
    return( () )
        unless(@matches);

    return(
        # Make a list of relative distances to
        # the nearest character match for each
        # position within the string
        map(
            {
                $current++
                    if($_ > $matches[$current]);

                min(
                    abs($_ - $matches[$current - 1]),
                    abs($_ - $matches[$current])
                );
            }
            0 .. length($ARG[0]) - 1
        )
    );

}



