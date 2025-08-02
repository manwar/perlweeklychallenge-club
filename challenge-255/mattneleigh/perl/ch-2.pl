#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @paragraphs_and_words = (
    [
        "Joe hit a ball, the hit ball flew far after it was hit.",
        "hit"
    ],
    [
        "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
       "the"
    ]
);

print("\n");
foreach my $paragraph_and_word (@paragraphs_and_words){
    printf(
        "Input: \$p = \"%s\"\n       \$w = \"%s\"\nOutput: \"%s\"\n\n",
        @{$paragraph_and_word},
        most_frequent_permitted_word(@{$paragraph_and_word})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a paragraph and a banned word, find the permitted word that appears
# most frequently in the paragraph
# Takes two arguments:
# * The paragraph to examine (e.g. "Joe hit a ball, the hit ball flew far after
#   it was hit." )
# * The word to ban (e.g. "hit")
# Returns:
# * The permitted word that appears most frequently in the paragraph (e.g.
#   "ball").  If there are multiple words tied for most frequent, the one that
#   sorts first, lexicographically speaking, will be returned
################################################################################
sub most_frequent_permitted_word{

    my %words;

    # Get a table of counts of permitted words
    foreach my $word (split(' ', $ARG[0])){
        # Stip anything that isn't a letter or number
        $word =~ s/[^A-Za-z0-9]//g;

        # If the word isn't the forbidden one, add to
        # its count in the word table
        if($word ne $ARG[1]){
            if($words{$word}){
                $words{$word}++;
            } else{
                $words{$word} = 1;
            }
        }
    }

    return(
        # 3: Get the 0th field of the 0th record in
        # the sorted list- this will be the most
        # frequently observed word
        (
            # 2: Sort the list in descending order by
            # count, unless the counts are equal, in
            # which case sort lexicographically
            sort(
                {
                    $b->[1] == $a->[1] ?
                        $a->[0] cmp $b->[0]
                        :
                        $b->[1] <=> $a->[1]
                }
                # 1: Make a list of words and their counts
                map(
                    [ $_, $words{$_} ],
                    keys(%words)
                )
            )
        )[0][0]
    );

}



