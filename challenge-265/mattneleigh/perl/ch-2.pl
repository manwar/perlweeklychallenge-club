#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [
        "aBc 11c",
        [ "accbbb", "abc", "abbc" ]
    ],
    [
        "Da2 abc",
        [ "abcm", "baacd", "abaadc" ]
    ],
    [
        "JB 007",
        [ "jj", "bb", "bjb" ]
    ],
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \$str = '%s'\n       \@str = (%s)\nOutput: '%s'\n\n",
        $word_list->[0],
        join(", ", map("'" . $_ . "'", @{$word_list->[1]})),
        shortest_completing_word($word_list)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string and a set of words, find the shortest Completing Word among
# the set, if any.  A Completing Word is defined as a word that contains all
# the letters in the given string, ignoring spaces and numbers; if a letter
# appears more than once in the given string, it must appear the same number of
# times or more in the word.  Note that letter-matching is case-insensitive.
# Takes one argument:
# * A ref to a data structure containing a string of characters and an array of
#   words to examine (e.g.
#       [
#           "aBc 11c",
#           [ "accbbb", "abc", "abbc" ]
#       ]
#   )
# Returns:
# * The shortest Completing Word, determined as described above, if any, or the
#   empty string if none of the supplied words were Completing Words (e.g.
#  "accbbb" )
################################################################################
sub shortest_completing_word{

    my %given_table;
    my $chr;
    my @completing;

    # Build a frequency table of the letters in the
    # given word
    foreach $chr (split(//, lc($ARG[0][0]))){
        next
            unless($chr =~ m/[a-z]/);
        $given_table{$chr}++;
    }

    # Examine each word
    foreach my $word (@{$ARG[0][1]}){
        my %word_table;
        my $completing = 1;

        # Build a frequency table of the letters in the
        # word
        foreach $chr (split(//, lc($word))){
            $word_table{$chr}++;
        }

        # Examine each letter from the given string
        foreach $chr (keys(%given_table)){
            # Set a flag to zero unless this letter appears
            # in the word and its count in the word was
            # greater than or equal to its count in the
            # given string
            $completing = 0
                unless(
                    $word_table{$chr}
                    &&
                    ($word_table{$chr} >= $given_table{$chr})
                );
        }

        # If the flag is true, this is a Completing
        # Word; store it in the list of same
        push(@completing, $word)
            if($completing);
    }

    return(
        # If there were Completing Words found, return
        # the shortest of them, otherwise return the
        # empty string
        scalar(@completing) ?
            (sort({ length($a) <=> length($b) } @completing))[0]
            :
            ""
    );

}



