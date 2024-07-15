#!/usr/bin/perl
use strict;
use warnings;

use List::Compare;

sub count_common {

    my ($words1, $words2) = @_;

    # Find common elements using List::Compare
    my $lc = List::Compare->new($words1, $words2);
    my @common_words = $lc->get_intersection;

    my %frequency;

    # Count frequencies of common words in both arrays
    foreach my $word (@common_words) {
        $frequency{$word}{words1} = scalar ( grep { $_ eq $word } @$words1 );
        $frequency{$word}{words2} = scalar ( grep { $_ eq $word } @$words2 );
    }

    # Filter words that appear exactly once in both arrays
    my @filtered_words = grep { $frequency{$_}{words1} == 1 &&
                                $frequency{$_}{words2} == 1 } @common_words;

    return(scalar @filtered_words);
}

# TESTS

my (@words1, @words2);

# Example 1
@words1 = ("Perl", "is", "my", "friend");
@words2 = ("Perl", "and", "Raku", "are", "friend");
print(count_common(\@words1, \@words2), "\n"); # Output: 2

# Example 2
@words1 = ("Perl", "and", "Python", "are", "very", "similar");
@words2 = ("Python", "is", "top", "in", "guest", "languages");
print(count_common(\@words1, \@words2), "\n"); # Output: 1

# Example 3
@words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional");
@words2 = ("Crystal", "is", "similar", "to", "Ruby");
print(count_common(\@words1, \@words2), "\n"); # Output: 0
