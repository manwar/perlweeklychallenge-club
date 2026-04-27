#!/usr/bin/perl
use strict;
use warnings;

sub popular_word {
    my ($paragraph, $banned_words) = @_;

    # 1) Normalize text to lowercase
    $paragraph = lc $paragraph;

    # 2) Replace unwanted punctuation with spaces
    # Keep letters, digits, whitespace, and apostrophes (for words like "don't")
    # See Example 6 below
    $paragraph =~ s/[^\w\s']/ /g;

    # 3) Split the paragraph into words (tokens)
    # \s+ means "one or more whitespace characters"
    my @words = split /\s+/, $paragraph;

    # 4) Build a lookup table (hash) for banned words
    # This makes checking very fast (O(1) per lookup)
    my %banned = map { lc($_) => 1 } @$banned_words;

    # 5) Count occurrences of each non-banned word
    my %seen;
    for my $word (@words) {

        # Skip empty strings (can happen if there are extra spaces)
        next if !$word;

        # Skip banned words
        next if $banned{$word};

        # Count the word
        $seen{$word}++;
    }

    # 6) Find the most frequent word
    my ($result, $max);

    foreach my $word (keys %seen) {

        # Update if:
        # - we don't have a max yet, OR
        # - this word appears more often, OR
        # - same frequency but lexicographically smaller (alphabetical order)
        if (!defined $max
            || $seen{$word} > $max
            || ($seen{$word} == $max && $word lt $result))
        {
            $max    = $seen{$word};
            $result = $word;
        }
    }

    # 7) Return the most frequent word (or undef if none found)
    return $result;
}

# Tests

my $paragraph;
my @banned;

# Example 1
$paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.";
@banned = ("hit");
print popular_word($paragraph, \@banned), "\n"; # Output: ball

# Example 2
$paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange.";
@banned = ("apple", "pear");
print popular_word($paragraph, \@banned), "\n"; # Output: "orange"

# Example 3
$paragraph = "A. a, a! A. B. b. b.";
@banned = ("b");
print popular_word($paragraph, \@banned), "\n"; # Output: "a"

# Example 4
$paragraph = "Ball.ball,ball:apple!apple.banana";
@banned = ("ball");
print popular_word($paragraph, \@banned), "\n"; # Output: "apple"

# Example 5
$paragraph = "The dog chased the cat, but the dog was faster than the cat.";
@banned = ("the", "dog");
print popular_word($paragraph, \@banned), "\n"; # Output: "cat"

# Example 6
my $paragraph = "Don't stop! Don't stop, don't stop. Believin'!";
my @banned = ("stop");
print popular_word($paragraph, \@banned), "\n"; # Output: "don't"
