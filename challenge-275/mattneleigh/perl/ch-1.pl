#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sentence_data_sets = (
    [
        "Perl Weekly Challenge",
        [ "l", "a" ]
    ],
    [
        "Perl and Raku",
        [ "a" ]
    ],
    [
        "Well done Team PWC",
        [ "l", "o" ]
    ],
    [
        "The joys of polyglottism",
        [ "T" ]
    ]
);

print("\n");
foreach my $sentence_data (@sentence_data_sets){
    printf(
        "Input: \$sentence = \"%s\", \@keys = (%s)\nOutput: %d\n\n",
        $sentence_data->[0],
        join(
            ", ",
            map(
                "'" . $_ . "'",
                @{$sentence_data->[1]}
            )
        ),
        count_words_with_unbroken_keys($sentence_data)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a sentence and a list of keys on a keyboard that are broken, determine
# how many words in the sentence can be typed properly, without the use of the
# broken keys
# Takes one argument:
# * A ref to an array that contains the sentence to examine, and an array of
#   broken keys (e.g.
#       [
#           "Well done Team PWC",
#           [ "l", "o" ]
#       ]
#   )
# Returns:
# * The count of words within the sentence that can be typed without the use of
#   the broken keys (e.g. 2 )
################################################################################
sub count_words_with_unbroken_keys{
    my $sentence_and_keys = shift();

    my $unbroken = 0;

    # Make a character class based on the broken
    # keys
    my $expr = "[" . join("", @{$sentence_and_keys->[1]}) . "]";

    # Compile and store a regex for future use-
    # with case-insensitive matching
    $expr = qr/$expr/i;

    # Examine each word in the sentence
    foreach my $word (split(" ", $sentence_and_keys->[0])){
        # Increment the counter of unbroken words if
        # this word does NOT include a broken key
        $unbroken++
            if($word !~ $expr);
    }

    return($unbroken);

}



