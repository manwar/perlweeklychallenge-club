#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [
        [ "one.two.three", "four.five", "six" ],
        "."
    ],
    [
        [ "\$perl\$\$", "\$\$raku\$" ],
        "\$"
    ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@words = (%s)\n\$separator = \"%s\"\nOutput: %s\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$word_list->[0]}
            )
        ),
        $word_list->[1],
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                split_by_delimiter($word_list)
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of strings and a delimeter character, separate all strings by
# that delimiter, returning a list of the resulting words
# Takes one argument:
# * A ref to a nested array that contains the array of strings and the
#   delimiter character (e.g.
#       [
#           # Word list
#           [ "one.two.three", "four.five", "six" ],
#
#           # Delimiter character
#           "."
#       ]
#   )
#   If the delimiter string has more than one character, only the first will be
#   used.
# Returns:
# * A list of words that have been separated by the specified delimiter (e.g.
#   ( "one", "two", "three", "four", "five", "six" ) )
# NOTE: Any empty fields indicated by repeated, leading, or trailing occurences
# of the delimiter character will not be returned
################################################################################
sub split_by_delimiter{

    # Make sure we're only using one character
    my $delimiter = substr($ARG[0][1], 0, 1);

    return(
        # Filter out empty fields returned by split()
        # via map()
        grep(
            $_ ne "",
            map(
                # Treat the delimiter as a member of a character
                # class so we don't have to worry about escaping
                # metacharacters when splitting
                split(/[$delimiter]/, $_),
                @{$ARG[0][0]}
            )
        )
    );

}



