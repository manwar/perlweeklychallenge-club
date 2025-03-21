#!/usr/bin/env perl

# Challenge 313
#
# Task 1: Broken Keys
# Submitted by: Mohammad Sajid Anwar
#
# You have a broken keyboard which sometimes type a character more than once.
#
# You are given a string and actual typed string.
#
# Write a script to find out if the actual typed string is meant for
# the given string.
# Example 1
#
# Input: $name = "perl", $typed = "perrrl"
# Output: true
#
# Here "r" is pressed 3 times instead of 1 time.
#
# Example 2
#
# Input: $name = "raku", $typed = "rrakuuuu"
# Output: true
#
# Example 3
#
# Input: $name = "python", $typed = "perl"
# Output: false
#
# Example 4
#
# Input: $name = "coffeescript", $typed = "cofffeescccript"
# Output: true

use Modern::Perl;

say is_typed(@ARGV) ? "true" : "false";

sub is_typed {
    my($string, $got) = @_;
    (my $match = $string) =~ s/(.)/$1+/g;
    return $got =~ /$match/;
}
