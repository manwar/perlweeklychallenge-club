#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sentences = (
    "and2 Raku3 cousins5 Perl1 are4",
    "guest6 Python1 most4 the3 popular5 is2 language7",
    "Challenge3 The1 Weekly2"
);

print("\n");
foreach my $sentence (@sentences){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $sentence,
        sort_shuffled_words($sentence)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string containing shuffled words and a numerical suffix that defines
# the order in which they should appear, correct the order of the sentence,
# removing each word's suffix in the process
# Takes one argument:
# * A string containing words and their sorting order, separated by spaces
#   (e.g. "Challenge3 The1 Weekly2" )
# Returns:
# * The sorted sentence (e.g. "The Weekly Challenge" )
################################################################################
sub sort_shuffled_words{

    return(
        # 5: Combine the sorted words into a sentence
        join(
            " ",
            # 4: Extract a list of just the words themselves
            map(
                $_->[0],
                # 3: Sort the word list by the specified sorting order
                sort(
                    { $a->[1] <=> $b->[1] }
                    # 2: Create an array of arrays containing the words and
                    # their sort order (e.g. [ "Challenge", 3 ] )
                    map(
                        [ ($_ =~ m/(.+)(\d+)$/) ],
                        # 1: Split the given sentence into its constituent
                        # words
                        split(/ /, shift())
                    )
                )
            )
        )
    );

}



