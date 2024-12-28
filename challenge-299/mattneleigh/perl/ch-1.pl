#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_sets = (
    [
        [ "cat", "bat", "rat" ],
        "the cattle was rattle by the battery"
    ],
    [
        [ "a", "b", "c" ],
        "aab aac and cac bab"
    ],
    [
        [ "man", "bike" ],
        "the manager was hit by a biker"
    ]
);

print("\n");
foreach my $word_set (@word_sets){
    printf(
        "Input: \@words = (%s)\n       \$sentence = \"%s\"\n" .
        "Output: \"%s\"\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$word_set->[0]}
            )
        ),
        $word_set->[1],
        replace_if_match_at_start($word_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of words and a sentence, replace all words in the sentence that
# start with any of the words in the list with that word from the list
# Takes one argument:
# * A ref to a structure that contains the list of replacement words and the
#   string to search through and replace (e.g.
#       [
#           [ "man", "bike" ],
#           "the manager was hit by a biker"
#       ]
#   )
# Returns:
# * The modified string (e.g. "the man was hit by a bike" )
################################################################################
sub replace_if_match_at_start{
    my $word_set = shift();

    my @words = split(" ", $word_set->[1]);

    # Examine each word
    foreach my $word (@words){
        # Check if this word begins with a replacement string
        foreach my $replacement (@{$word_set->[0]}){
            if($word =~ m/^$replacement/){
                # It did- replace it and break out of this loop;
                # replacement works as $word is aliased to the
                # original in @words
                $word = $replacement;
                last;
            }
        }
    }

    # Return the string made from the replaced word set
    return(join(" ", @words));

}



