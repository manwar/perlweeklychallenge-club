#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @keyboard_rows = (
    "qwertyuiop",
    "asdfghjkl",
    "zxcvbnm"
);
my @word_lists = (
    # Given cases
    [ "Hello", "Alaska", "Dad", "Peace" ],
    [ "OMG", "Bye" ],

    # Additional test cases
    [ "Hello", "world", "woot", "hooray" ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@words = (%s)\nOutput: (%s)\n\n",
        list_to_quoted_string(@{$word_list}),
        list_to_quoted_string(
            single_row_words(\@keyboard_rows, $word_list)
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine which words in a list can be typed using keys from only one row of
# a specified keyboard layout
# Takes two arguments:
# * A reference to a list of strings comprising the letters of each row of a
#   keyboard (e.g. [ "qwertyuiop", asdfghjkl", "zxcvbnm" ] )
# * A reference to a list of words to examine (e.g. [ "Hello", "world", "woot",
#   "hooray" ] )
# Returns:
# * A list of words from the second list that can be typed using only one row
#   of the keyboard layout described in the first list (e.g. ( "woot") )
# NOTE: Letter comparisons are done case-insensitively
################################################################################
sub single_row_words{

    # Compile regexes based on each row forming
    # a character class with the keys in said
    # row as members; we will match case-
    # insensitively
    my @keyboard_regexes = map(
        qr/[$_]/i,
        @{$ARG[0]}
    );

    return(
        map(
            # Run this block on every string form the
            # second argument
            {
                my $ct = 0;

                # Check each string for the presence of
                # characters from each keyboard row, and
                # count up the matches
                foreach my $row_regex (@keyboard_regexes){
                    $ct++
                        if($_ =~ /$row_regex/);

                    last
                        if($ct > 1);
                }

                # Pass this string along to the returned
                # list only if exactly one keyboard row
                # matched
                ($ct != 1) ? () : $_;

            }
            @{$ARG[1]}
        )
    );

}



################################################################################
# Build a quoted, comma-separated string out of the contents of a list
# Takes one argument:
# * The list (e.g. ( 1, 2, 3, 4 )
# Returns:
# * A quoted, comma-separated string containing the contents of the list (e.g.
#   ""1", "2", "3", "4"")
################################################################################
sub list_to_quoted_string{

    return(
        # (2) Join the quoted strings together
        # with commas
        join(
            ", ",
            # (1) Put quotes around each list member
            map(
                "\"".$_."\"",
                @ARG
            )
        )
    );

}



