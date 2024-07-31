#!/usr/bin/perl
use strict;
use warnings;

sub split_string {

    # this task can be solved in an easy way:
    # if the number of vowels is even, the string can be split as required

    # extra test if the string contains at least one vowel

    ($_[0] =~ (tr/aeiou//) &&
     $_[0] =~ (tr/aeiou//) % 2 == 0) ?
                                         return("true")
                                     :
                                         return("false");

}

# Tests

my $str;

# Example 1
$str = "perl";
print(split_string($str), "\n"); # Output: false

# Example 2
$str = "book";
print(split_string($str), "\n"); # Output: true

# Example 3
$str = "good morning";
print(split_string($str), "\n"); # Output: true

# Example 4
$str = "bcdfghjklmnpqrstvwxyz";
print(split_string($str), "\n"); # Output: false
