#!/usr/bin/perl
use strict;
use warnings;

sub word_sorter {
    join " ",
    sort { lc($a) cmp lc($b) }
    grep length, # Keep only the elements whose length is not zero: Example 6
    split /\s+/, shift;
}

# Tests

my $str;

# Example 1
$str = "The quick brown fox";
printf "%s\n", word_sorter($str); # Output: "brown fox quick The"

# Example 2
$str = "Hello    World!   How   are you?";
printf "%s\n", word_sorter($str); # Output: "are Hello How World! you?"

# Example 3
$str = "Hello";
printf "%s\n", word_sorter($str); # Output: "Hello"

# Example 4
$str = "Hello, World! How are you?";
printf "%s\n", word_sorter($str); # Output: "are Hello, How World! you?"

# Example 5
$str = "I have 2 apples and 3 bananas!";
printf "%s\n", word_sorter($str); # Output: "2 3 and apples bananas! have I"

# Example 6
$str = "  foo   bar  baz  ";
printf "%s\n", word_sorter($str); # Output: "bar baz foo"
