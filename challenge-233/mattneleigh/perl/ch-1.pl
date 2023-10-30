#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [ "aba", "aabb", "abcd", "bac", "aabc" ],
    [ "aabb", "ab", "ba" ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@words = (%s)\nOutput: %d\n\n",
        join(", ", map("\"" . $_ . "\"", @{$word_list})),
        count_similar_word_pairs(@{$word_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the pairs of similar words in a list, where similar words are defined
# as those having the same (and only the same) letters between them, though
# the letters may appear in different quantities and orders; case is ignored
# for the purpose of identifying matching letters
# Takes one argument:
# * A list of words to examine (e.g. ( "aba", "aabb", "abcd", "bac", "aabc" ) )
# Returns:
# * The number of pairs of similar words in the list (e.g. 2 )
################################################################################
sub count_similar_word_pairs{

    my @strings;
    my $pairs = 0;

    while(@ARG){
        # Store a condensed copy of each word with all
        # letters lower-cased and sorted...
        push(
            @strings,
            join("", sort(split("", lc(shift()))))
        );

        # ...and non-letters removed...
        $strings[$#strings] =~ s/\P{L}//g;

        # ...and duplicate letters removed
        $strings[$#strings] =~ s/(.)\1+/$1/g;
    }

    # Compare every pair of condensed words
    foreach my $i (0 .. $#strings - 1){
        foreach my $j ($i + 1 .. $#strings){
            # Increment the pair count if these two
            # condensed words are identical (the original
            # words contained the same- and only the same-
            # letters)
            $pairs++
                if($strings[$j] eq $strings[$i]);
        }
    }

    return($pairs);

}



