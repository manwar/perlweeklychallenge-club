#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sentences = (
    "I love Perl",
    "Perl and Raku are friends",
    "The Weekly Challenge"
);

print("\n");
foreach my $sentence (@sentences){
    printf(
        "Input: \$sentence = \"%s\"\nOutput: \"%s\"\n\n",
        $sentence,
        to_goat_latin($sentence)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Convert a supplied sentence to Goat Latin, by processing each word according
# to the following rules:
#   1) If a word begins with a vowel, append "ma" to the end of the word
#   2) If a word begins with consonant, remove the first letter and append it
#      to the end, then append "ma"
#   3) Append letter "a" to the end of first word in the sentence, "aa" to the
#      second word, etc etc.
# Takes one argument:
# * A sentence to examine (e.g. "I love Perl")
# Returns:
# * The supplied sentence, converted to Goat Latin (e.g. "Imaa ovelmaaa
#   erlPmaaaa")
################################################################################
sub to_goat_latin{

    my @words = split(" ", $ARG[0]);
    my $suffix = "ma";

    # Examine each word
    foreach my $word (@words){
        if($word !~ m/^[aeiouAEIOU]/){
            # Word begins with a not-vowel- swap
            # its first letter to the end (substr()
            # removes the character from $word en
            # passant before returning it to be
            # appended)
            $word .= substr($word, 0, 1, "");
        }

        # Add "ma" suffix plus the appropriate
        # number of a's, which will increase
        # with each word
        $word .= ($suffix .= "a");
    }

    # Recombine the words into a sentence
    # and return
    return(join(" ", @words));

}



