#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @captions = (
    "Cooking with 5 ingredients!",
    "the-last-of-the-mohicans",
    "  extra spaces here",
    "iPhone 15 Pro Max Review",
    "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
);

print("\n");
foreach my $caption (@captions){
    printf(
        "Input: \$caption = \"%s\"\nOutput: \"%s\"\n\n",
        $caption,
        tag_from_caption($caption)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string containing a caption that describes a video, generate a
# hashtag for it according to the following rules:
# 1) The caption will be formatted without spaces in camel case (i.e.
#    "This is camel case" -> "thisIsCamelCase")
# 2) All characters that are not letters in English (i.e. A-Z, a-z) will be
#    filtered out
# 3) The length of the hashtag, including the leading '#', will be limited to
#    100 characters
# Takes one argument:
# * The caption to convert into a tag (e.g. "Cooking with 5 ingredients!")
# Returns:
# * The hashtag generated in accordance with the rules stated above (e.g.
#   "#cookingWithIngredients")
################################################################################
sub tag_from_caption{
    # Lower-case the caption and split it on
    # whitespace; this will filter out leading
    # and trailing whitespace en passant
    my @words = split(" ", lc(shift()));

    # Camel-case each word, among other things
    foreach my $i (0 .. $#words){
        # Delete non-letter characters
        $words[$i] =~ s/[^A-Za-z]//g;

        # Capitalize the first letter of the second
        # and subsequent words
        substr($words[$i], 0, 1, uc(substr($words[$i], 0, 1)))
            if($i);
    }

    # Re-combine the words, prepend with '#', and
    # truncate the result to 100 characters
    return(substr("#" . join("", @words), 0, 100));

}



