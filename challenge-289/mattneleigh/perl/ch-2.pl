#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sentences = (
    "The quick, brown fox jumped over the lazy dog.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "The fool doth think he is wise, but the wise man knows himself to be a fool."
);

print("\n");
foreach my $sentence (@sentences){
    printf(
        "Input:  %s\nOutput: %s\n\n",
        $sentence,
        recognizeable_word_jumble($sentence)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Jumble the medial latters (those not at the start and end) of each word in a
# sentence, leaving all other characters in place.  This is based on the idea
# that words in a sentence remain easily readable as long as the first and last
# letters are unchanged even if all the others are randomly rearranged.
# Takes one argument
# * The sentence to shuffle (e.g. "The quick, brown fox jumped over the lazy
#   dog.")
# Returns:
# * The sentence with all medial letter shuffled (e.g. "The quick, borwn fox
#   juempd oevr the lzay dog." [exact medial letter arrangement to vary with
#   each call; some words may pass through unchanged])
################################################################################
sub recognizeable_word_jumble{

    return(
        # 3. Re-join the groups of jumbled and
        # not-jumbled characters into one string
        join(
            "",
            # 2. Run the char jumbler on each set of
            # letters of sufficient length; pass not-
            # letters and short groups of letters
            # through unchanged
            map(
                ((length($_) > 3) && m/[[:alpha:]]/) ?
                    shuffle_medial_string($_)
                    :
                    $_,
                # 1. Split the input string into groups of
                # letters and groups of not-letters by
                # splitting on collections of letters and
                # capturing the "delimiters"
                split(/([[:alpha:]]+)/, shift())
            )
        )
    );

}



################################################################################
# Shuffle the medial contents of a string- that is to say, rearrange in random
# order all the characters that are NOT the first and last.  Note that calling
# this function on a string of fewer than four characters is futile as the
# order of a single medial character is impossible to change.  Shuffling is
# accomplished via the Fisher-Yates method (see
# https://en.wikipedia.org/wiki/Fisher-Yates_shuffle )
# Takes one argument:
# * The string to shuffle (e.g. "Programming")
# Returns:
# * The shuffled string (e.g. "Pmgmrnioarg" [exact medial letter arrangement to
#   vary with each call; some strings may pass through unchanged if random
#   chance or their length so dictates])
################################################################################
sub shuffle_medial_string{
    # Break up the word into its component
    # characters
    my @chars = split(//, shift());

    my ($i, $j);
    my $temp;

    # Run the Fisher-Yates Shuffle on the array
    # of chars EXCEPT the first and last, which
    # are to remain in place
    for $i (1 .. $#chars - 2){
        # Select a random char to swap with the
        # current one, within the range of
        # swappable chars
        $j = $i + int(rand($#chars - $i));

        # Swap the chars at $i and $j; doing it
        # this way turns out to be somewhat faster
        # than using array slices (e.g.
        # @chars[$i, $j] = @chars[$j, $i]; )
        $temp = $chars[$i];
        $chars[$i] = $chars[$j];
        $chars[$j] = $temp;
    }

    # Recombine all chars and return the
    # resulting string
    return(join("", @chars));
    
}



