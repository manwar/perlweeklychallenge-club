#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sentence_groups = (
    [
        "Hello world",
        "This is a test",
        "Perl is great"
    ],
    [
        "Single"
    ],
    [
        "Short",
        "This sentence has seven words in total",
        "A B C",
        "Just four words here"
    ],
    [
        "One",
        "Two parts",
        "Three part phrase",
        ""
    ],
    [
        "The quick brown fox jumps over the lazy dog",
        "A",
        "She sells seashells by the seashore",
        "To be or not to be that is the question"
    ]
);

print("\n");
foreach my $sentence_group (@sentence_groups){
    printf(
        "Input: \@sentences = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$sentence_group}
            )
        ),
        max_words_in_sentence(@{$sentence_group})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of sentences, determine how many words are in the sentence
# with the most words
# Takes one argument:
# * An array of sentences (e.g. ( "One", "Two parts", "Three part phrase", "" )
#   )
# Returns:
# * The maximum number of words found within each individual sentenc (e.g. 3)
################################################################################
sub max_words_in_sentence{
    use List::Util qw(max);
    
    return(
        # 2) Determine the maxium among the counts
        # computed
        max(
            map(
                # 1) Split each sentence on whitespace and
                # count the words produced
                scalar(split(" ", $_)),
                @ARG
            )
        )
    );

}



