#!/usr/bin/perl

use strict;
use warnings;

sub max_words_in_sentences {
    my @sentences = @_;

    my $max = 0;

    for my $s (@sentences) {
        my @words = split ' ', $s;
        my $count = scalar @words;
        $max = $count if $count > $max;
    }

    return $max;
}

sub show_result {
    my (@sentences) = @_;

    print "Input: \@sentences = (\""
        . join("\", \"", @sentences) . "\")\n";

    my $max = max_words_in_sentences(@sentences);
    print "Output: $max\n\n";
}

# Example 1
show_result("Hello world", "This is a test", "Perl is great");

# Example 2
show_result("Single");

# Example 3
show_result("Short", "This sentence has seven words in total", "A B C", "Just four words here");

# Example 4
show_result("One", "Two parts", "Three part phrase", "");

# Example 5
show_result("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question");
