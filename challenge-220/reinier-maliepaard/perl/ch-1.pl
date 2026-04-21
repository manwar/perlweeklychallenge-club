#!/usr/bin/perl
use strict;
use warnings;

sub common_characters {
    my ($arr) = @_;

    my %freq;

    for my $word (@$arr) {

    	# %seen keeps track of characters already found in THIS word
        # This avoids counting duplicates in the same word
        my %seen;

        for my $c (split //, lc $word) {
            $seen{$c} = 1; # mark character as seen in this word
        }

        # Now count each character ONLY ONCE per word
        # (using keys %seen ensures uniqueness)
        $freq{$_}++ for keys %seen;
    }

    my $no_of_words = scalar @$arr;
    my @res;
    foreach my $item (keys %freq) {
        # If a character appears in ALL words,
        # its count will equal the total number of words
        if ($freq{$item} == $no_of_words) {
            push @res, $item;
        }
    }

    return sort @res;
}

# Tests

my @words;

# Example 1
@words = ("Perl", "Rust", "Raku");
print "(" . join(", ", common_characters(\@words)) . ")\n"; # Output: ("r")

# Example 2
@words = ("love", "live", "leave");
print "(" . join(", ", common_characters(\@words)) . ")\n"; # Output: ("e", "l", "v")
