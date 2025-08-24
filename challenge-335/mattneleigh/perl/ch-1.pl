#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [ "bella", "label", "roller" ],
    [ "cool", "lock", "cook" ],
    [ "hello", "world", "pole" ],
    [ "abc", "def", "ghi" ],
    [ "aab", "aac", "aaa" ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@words = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$word_list}
            )
        ),
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                present_in_all_words(@{$word_list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an list of words, determine which letters are common to every word in
# the list.  If a letter appears twice or more in each word, it will appear in
# the output that number of times; if there are no common letters among the
# supplied words, an empty list will be returned.
# Takes one argument:
# * The list of words to examine (e.g. ("bella", "label", "roller") )
# Returns:
# * A sorted list of letters common to all words in the supplied list,
#   including multiple instances of letters that appear more than once in all
#   words (e.g. ("e", "l", "l") )
################################################################################
sub present_in_all_words{
    # Split all words into arrays of their component
    # letters
    my @words = map(
        [ sort(split('', $_)) ],
        @ARG
    );

    my @common;
    my $letter;
    my $word;
    my $count;
    my $i;

    # Loop while there are remaining letters from
    # the first word
    while(@{$words[0]}){
        # Extract the next letter from the first word
        $letter = shift(@{$words[0]});
        $count = 0;
        
        # Examine all subsequent words
        foreach $word (@words[1 .. $#words]){
            # Examine the remaining letters in the current
            # word
            for $i (0 .. $#$word){
                if($word->[$i] eq $letter){
                    # This letter was a match- remove it from the
                    # current word, add to the count, and move on to
                    # the next word
                    splice(@{$word}, $i, 1);
                    $count++;
                    last;
                }
            }
        }

        # If this letter was seen in all subsequent
        # words, add it to the list of common letters
        push(@common, $letter)
            if($count == (scalar(@words) - 1));
    }

    # Return the sorted list of common letters
    return(sort(@common));

}



