#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @searches = (
    [
        qq^""[]()^,
        qq^"I like (parens) and the Apple ][+" they said.^
    ],
    [
        "**//<>",
        "/* This is a comment (in some languages) */ <could be a tag>"
    ]
);
my $search;

foreach $search (@searches){
    printf(
        "Input:\n    Delimiter pairs: %s\n    Search String: %s\n\n",
        @{$search}
    );
    printf(
        "Output:\n    %s\n    %s\n\n\n",
        find_delimiter_pairs(@{$search})
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find specified delimiters within a string
# Takes two arguments:
# * A string of opening and closing delimiter characters to look for- these
#   must be grouped in pairs (e.g. "\"\"()<>" not "\"(<)>\"") so the even-
#   numbered characters (starting from 0) will be interpreted as opening
#   delimiters and the odd ones as closing delimiters
# * A string in which to look for said delimiter characters
# Returns:
# * A list containing:
#   - A string of occurrences of the opening delimiters
#   - A string of occurrences of the closing delimiters
# NOTE: If a character appears in both opening and closing delimiter sets (e.g.
# quotes or similar) instances of it from the search string will be added to
# both output sets
################################################################################
sub find_delimiter_pairs{

    my $i = 0;
    my $opening = "";
    my $closing = "";
    my $opening_found = "";
    my $closing_found = "";

    # Break the delimiter string into even
    # and odd characters
    foreach(split("", $ARG[0])){
        if($i++ % 2){
            # Odd character
            $closing .= $_;
        } else{
            # Even character
            $opening .= $_;
        }
    }

    # Escape metacharacters in the
    # delimiter string
    $ARG[0] = quotemeta($ARG[0]);

    # Keep searching through the string
    # while specified delimiter characters
    # are still found
    while($ARG[1] =~ m/([$ARG[0]])/gc){
        my $chr = $1;

        # Store a copy of the character for
        # searching, with metacharacter
        # escaped as needed
        $_ = quotemeta($chr);

        # Determine which sets should
        # contain this character (it may
        # appear in both)
        if($opening =~ m/$_/){
            # Opening delimiter found
            $opening_found .= $chr;
        }
        if($closing =~ m/$_/){
            # Closing delimiter found
            $closing_found .= $chr;
        }
    }

    return($opening_found, $closing_found);

}



