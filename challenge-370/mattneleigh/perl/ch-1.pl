#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @paragraph_data_sets = (
    [
        "Bob hit a ball, the hit BALL flew far after it was hit.",
        [ "hit" ]
    ],
    [
        "Apple? apple! Apple, pear, orange, pear, apple, orange.",
        [ "apple", "pear" ]
    ],
    [
        "A. a, a! A. B. b. b.",
        [ "b" ]
    ],
    [
        "Ball.ball,ball:apple!apple.banana",
        [ "ball" ]
    ],
    [
        "The dog chased the cat, but the dog was faster than the cat.",
        [ "the", "dog" ]
    ]
);

print("\n");
foreach my $paragraph_data (@paragraph_data_sets){
    printf(
        "Input: \$paragraph = \"%s\"\n       \@banned = (%s)\n" .
        "Output: \"%s\"\n\n",
        $paragraph_data->[0],
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$paragraph_data->[1]}
            )
        ),
        most_popular_permitted_word(@{$paragraph_data})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a paragraph and a list of banned words, determine which permitted word
# appears most within the supplied paragraph
# Takes two arguments:
# * The paragraph to examine (e.g. "Bob hit a ball, the hit BALL flew far after
#   it was hit.")
# * A ref to a list of banned words (e.g. [ "hit" ] )
# Returns:
# * The most frequently seen word that isn't banned (e.g. "ball")
################################################################################
sub most_popular_permitted_word{
    # Lowercase the paragraph, and convert the
    # list of banned words into a hash for easy
    # lookup
    my $paragraph = lc(shift());
    my %banned = map(
        { $_ => 1 }
        @{shift()}
    );

    my @words;
    my %counts;

    # Replace anything that isn't a letter or a
    # space with spaces, and split the paragraph
    # into words
    $paragraph =~ s/[^a-z ]/ /g;
    @words = split(" ", $paragraph);

    # Count words that are not on the banned list
    foreach my $word (@words){
        $counts{$word}++
            unless($banned{$word});
    }

    # Sort the un-banned words in descending
    # order by use count and return the first-
    # which will be the most popular unbanned
    # word
    return(
        (sort({ $counts{$b} <=> $counts{$a} } keys(%counts)))[0]
    );

}



