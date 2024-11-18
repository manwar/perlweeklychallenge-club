#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [ "weeklychallenge", [ "challenge", "weekly" ] ],
    [ "perlrakuperl", [ "raku", "perl" ] ],
    [ "sonsanddaughters", [ "sons", "sand", "daughters" ] ],
);

print("\n");
foreach my $string_set (@string_sets){
    printf(
        "Input: \$str = \"%s\", \@words = (%s)\nOutput: %s\n\n",
        $string_set->[0],
        join(", ", map("\"" . $_ . "\"", @{$string_set->[1]})),
        segmentable_into_words($string_set) ?
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
# Determine whether all the words in a list can be split from a given string
# Takes one argument:
# * A ref to an array that contains the string to examine and the words to
#   look for therein (e.g.
#       [
#           "perlrakuperl",
#           [ "raku", "perl" ]
#       ]
#   )
# Returns:
# * 0 if the supplied words could NOT be split from the supplied string
# * 1 if the supplied words could be split from the supplied string
################################################################################
sub segmentable_into_words{
    my ($string, $list) = @{shift()};

    # Examine each word
    foreach my $word (@{$list}){
        # If the word is present in the string,
        # remove it and skip to the next word
        next
            if($string =~ s/$word//g);

        # This word does not appear in the
        # remaining string; return false
        return(0);
    }

    # Got here- all words were present;
    # return true
    return(1);

}



