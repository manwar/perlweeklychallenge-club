#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @words = (
    [ "challenge",   "e" ],
    [ "programming", "a" ],
    [ "champion",    "b" ]
);

print("\n");
foreach my $word (@words){
    printf(
        "Input: \$str = \"%s\", \$char = \"%s\"\nOuput: \"%s\"\n\n",
        $word->[0],
        $word->[1],
        character_substring_sort($word)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a word and a character to look for, sort all characters in the word up
# to and including the first instance of the specified character, in
# lexicographical order; if the character was not found within the word, no
# changes will be made and the word returned without modification
# Takes one argument:
# * A ref to an array that contains a word and a character to look for (e.g.
#   [ "challenge",   "e" ] )
# Returns:
# * The word processed as described above, with all characters up to and
#   including the first instance of the specified character sorted in
#   lexicographical order (e.g. "acehllnge" ).  If the specified character was
#   not present in the word, the word is returned unmodified.
################################################################################
sub character_substring_sort{

    # See if the word has the desired character...
    if($ARG[0][0] =~ m/^([^$ARG[0][1]]*[$ARG[0][1]])(.*)$/){
        # It did- we captured the first instance of it and all
        # characters that preceded it in $1, and all subsequent
        # characters in $2; split the contents of $1, sort
        # them, join them together, concatenate them with $2,
        # and return the result
        return(join("", sort(split("", $1))) . $2);
    } else{
        # It didn't- return the unmodified string
        return($ARG[0][0]);
    }

    return(0);

}



