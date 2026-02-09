#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @words = (
    "aabbccdd",
    "abccba",
    "abcdef",
    "aabbaeaccdd",
    "mississippi"
);

print("\n");
foreach my $word (@words){
    printf(
        "Input: \$word = \"%s\"\nOutput: \"%s\"\n\n",
        $word,
        remove_adjacent_pairs($word)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Repeatedly remove adjacent duplicate letters from a word until no such pairs
# remain, even those created by the removal of previous pairs
# Takes one argument:
# * The word to examine (e.g. "mississippi")
# Returns:
# * The word after processing such that no duplicate letters remain (e.g. "m")
################################################################################
sub remove_adjacent_pairs{
    my $word = shift();

    # Loop while there are adjacent pairs of
    # letters, removing them as we go
    while($word =~ s/(.)\1//g){
        ;;
    }

    return($word);

}



