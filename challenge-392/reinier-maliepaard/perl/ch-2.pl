#!/usr/bin/perl
use strict;
use warnings;

# Algorithm:
# 1. Sort by decreasing length.
# 2a. Find the first compatible pair and return its product.
# 2b. If no pair exists, return 0.

sub max_product_words_length {
    my @arr = @_;

    die "Need at least 2 words\n" if @arr < 2;

    # Sort by decreasing length
    @arr = sort { length($b) <=> length($a) } @arr;

    for my $i (0 .. @arr - 2) {
        for my $j ($i + 1 .. @arr - 1) {

            # Skip pairs with a character in common
            next if $arr[$i] =~ /[$arr[$j]]/;

            # First compatible pair has the maximum product
            return length($arr[$i]) * length($arr[$j]);
        }
    }

    return 0; # No compatible pair
}

# Tests

my @words;

# Example 1
@words = ("a", "ab", "abc", "d", "de", "def");
print max_product_words_length(@words), "\n"; # Output: 9

# Example 2
@words = ("a", "aa", "aaa", "aaaa");
print max_product_words_length(@words), "\n"; # Output: 0

# Example 3
@words = ("meet", "app", "code", "sky", "bold");
print max_product_words_length(@words), "\n"; # Output: 16

# Example 4
@words = ("a", "ab", "abc", "abcd", "efghi");
print max_product_words_length(@words), "\n"; # Output: 20

# Example 5
@words = ("xyz", "w", "abcdefg", "hij");
print max_product_words_length(@words), "\n"; # Output: 21
