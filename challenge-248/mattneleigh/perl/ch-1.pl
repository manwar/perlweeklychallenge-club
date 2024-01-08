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
    [ "computersarefun", "e" ],
    [ "programmingrules", "p" ],
    [ "greatforproblemsolving", "g" ],
    [ "lovelexicalvariables", "x" ],
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

    my $current_loc = 0;
    my @matches;
    my $char = substr($ARG[1], 0, 1);

    # Attempt to match the character in the
    # string, taking note of the location of
    # each occurrence; this is faster than
    # regex for this simple case
    foreach my $current_char (split('', $ARG[0])){
        push(@matches, $current_loc)
            if($char eq $current_char);

        $current_loc++;
    }

    # Return an empty list if the character
    # wasn't found
    return( () )
        unless(@matches);

    my $dist_ahead;
    my $dist_behind;

    $current_loc = 0;

    return(
        # Make a list of relative distances to
        # the nearest character match for each
        # position within the string
        map(
            {
                if($_ <= $matches[0]){
                    # We're at or before the first match
                    # in the list; also covers cases of
                    # just one match
                    $matches[0] - $_;
                } elsif($_ >= $matches[$#matches]){
                    # We're at or beyond the last match in
                    # the list; also covers cases of just
                    # one match
                    $_ - $matches[$#matches];
                } else{
                    # We're between matches...

                    # Increment the current match position
                    # if we've passed the previous one
                    $current_loc++
                        if($_ > $matches[$current_loc]);

                    # Get distances to the nearest matches
                    # ahead and behind
                    $dist_behind = $_ - $matches[$current_loc - 1];
                    $dist_ahead = $matches[$current_loc] - $_;

                    # See which distance is smaller; doing
                    # it this way is somewhat faster for
                    # this simple case than calling
                    # List::Util::min() directly on the
                    # values involved, on most systems- as
                    # long as the variables are lexically
                    # scoped outside of this block
                    $dist_behind < $dist_ahead ?
                        $dist_behind
                        :
                        $dist_ahead;
                }
            }
            0 .. length($ARG[0]) - 1
        )
    );

}



