#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sentence_groups = (
    [
        "Perl and Raku belong to the same family.",
        "I love Perl.",
        "The Perl and Raku Conference."
    ],
    [
        "The Weekly Challenge.",
        "Python is the most popular guest language.",
        "Team PWC has over 300 members."
    ]
);

print("\n");
foreach my $sentence_group (@sentence_groups){
    printf(
        "Input: \@list = (%s)\nOutput: %d\n\n",
        join(
            ",\n                ",
            map("\"$_\"", @{$sentence_group})
        ),
        calculate_maximum_words_in_group(@{$sentence_group})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the maximum number of words in a sentence within a group of
# sentences
# Takes one argument:
# * An array of sentences, which make up the group to examine (e.g.
#       (
#           "This is a sentence.",
#           "This is a longer sentence."
#           "This is an even longer sentence."
#       )
#   )
# Returns:
# * The word count from the sentence within the group that has the most words
#   (e.g. 6 )
################################################################################
sub calculate_maximum_words_in_group{
    use List::Util qw(max);

    return(
        # Find the maximum value in the list
        # of word counts
        max(
            # Make a list of the number of words
            # in each sentence
            map(
                scalar(split(/ /, $_)),
                @ARG
            )
        )
    );

}



