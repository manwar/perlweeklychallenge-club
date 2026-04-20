#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-370/#TASK1
#
# Task 1: Popular Word
# ====================
#
# You are given a string paragraph and an array of the banned words.
#
# Write a script to return the most popular word that is not banned. It is
# guaranteed there is at least one word that is not banned and the answer is
# unique. The words in paragraph are case-insensitive and the answer should be
# in lowercase. The words can not contain punctuation symbols.
#
## Example 1
##
## Input: $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
##        @banned = ("hit")
## Output: "ball"
##
## After removing punctuation and converting to lowercase, the word "hit"
## appears 3 times, and "ball" appears 2 times.
## Since "hit" is on the banned list, we ignore it.
#
## Example 2
##
## Input: $paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
##        @banned = ("apple", "pear")
## Output: "orange"
##
## "apple"  appears 4 times.
## "pear"   appears 2 times.
## "orange" appears 2 times.
##
## "apple" and "pear" are both banned.
## Even though "orange" has the same frequency as "pear", it is the only
## non-banned word with the highest frequency.
#
## Example 3
##
## Input: $paragraph = "A. a, a! A. B. b. b."
##        @banned = ("b")
## Output: "a"
##
## "a" appears 4 times.
## "b" appears 3 times.
##
## The input has mixed casing and heavy punctuation.
## The normalised, "a" is the clear winner, since "b" is banned, "a" is the only
## choice.
#
## Example 4
##
## Input: $paragraph = "Ball.ball,ball:apple!apple.banana"
##        @banned = ("ball")
## Output: "apple"
##
## Here the punctuation acts as a delimiter.
## "ball"   appears 3 times.
## "apple"  appears 2 times.
## "banana" appears 1 time.
#
## Example 5
##
## Input: $paragraph = "The dog chased the cat, but the dog was faster than the cat."
##        @banned = ("the", "dog")
## Output: "cat"
##
## "the" appears 4 times.
## "dog" appears 2 times.
## "cat" appears 2 times.
##
## "chased", "but", "was", "faster", "than" appear 1 time each.
## "the" is the most frequent but is banned.
## "dog" is the next most frequent but is also banned.
## The next most frequent non-banned word is "cat".
#
############################################################
##
## discussion
##
############################################################
#
# We split the sentence into its word by splitting at non-word characters.
# Then we check for each word whether it is in @banned - if it isn't, we
# count the word. In the end we sort the different words by count and pick
# the first element of that sorted list as the result.

use v5.36;

scramble_string("Bob hit a ball, the hit BALL flew far after it was hit.", ("hit"));
scramble_string("Apple? apple! Apple, pear, orange, pear, apple, orange.", ("apple", "pear"));
scramble_string("A. a, a! A. B. b. b.", ("b"));
scramble_string("Ball.ball,ball:apple!apple.banana", ("ball"));
scramble_string("The dog chased the cat, but the dog was faster than the cat.", ("the", "dog"));

sub scramble_string($paragraph, @banned) {
    say "Input: \$paragraph = \"$paragraph\"";
    say "       \@banned = (\"" . join("\", \"", @banned) . "\")";
    my @words = split /\W+/, $paragraph;
    my $found;
    OUTER:
    foreach my $word (@words) {
        foreach my $ban (@banned) {
            next OUTER if lc($word) eq lc($ban);
        }
        $found->{lc($word)}++;
    }
    my @allowed_words = sort { $found->{$b} <=> $found->{$a} } keys %$found;
    say "Output: \"" . shift @allowed_words . "\"";
}

