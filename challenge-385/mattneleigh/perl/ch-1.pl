#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sentence_pairs = (
    [
        "apple banana apple",
        "banana orange"
    ],
    [
        "cat dog",
        "bird fish"
    ],
    [
        "the quick brown fox",
        "the quick"
    ],
    [
        "hello",
        "hello"
    ],
    [
        "blue blue red",
        "red green green yellow"
    ]
);

print("\n");
foreach my $sentence_pair (@sentence_pairs){
    printf(
        "Input: \$sentence1 = \"%s\"\n       \$sentence2 = \"%s\"\n"
        .
        "Output: (%s)\n\n",
        $sentence_pair->[0],
        $sentence_pair->[1],
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                uncommon_words(@{$sentence_pair})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two sentences, find the Uncommon Words among them- that is to say, the
# words that only appear once among all the words in both sentences
# Takes two arguments:
# * The first sentence to examine (e.g. "apple banana apple")
# * The second sentence to examine (e.g. "banana orange")
# Returns:
# * A list of Uncommon Words found among those that make up the two provided
#   sentences (e.g. ("orange") )
# - OR -
# * An empty list if no Uncommon Words were found
################################################################################
sub uncommon_words{

    my %words;

    # Count each unique word among the provided
    # sentences
    foreach(@ARG){
        foreach(split(" ", $_)){
            $words{$_}++;
        }
    }

    # Return a list of words that appeared only
    # once among all the words in both sentences
    return(
        map(
            $words{$_} == 1 ? $_ : (),
            keys(%words)
        )
    );

}



