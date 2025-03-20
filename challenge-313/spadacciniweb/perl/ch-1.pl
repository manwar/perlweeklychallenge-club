#!/usr/bin/env perl

# Task 1: Broken Keys
# Submitted by: Mohammad Sajid Anwar
#
# You have a broken keyboard which sometimes type a character more than once.
# You are given a string and actual typed string.
# Write a script to find out if the actual typed string is meant for the given string.
# 
# Example 1
# Input: $name = "perl", $typed = "perrrl"
# Output: true
# Here "r" is pressed 3 times instead of 1 time.
#
# Example 2
# Input: $name = "raku", $typed = "rrakuuuu"
# Output: true
#
# Example 3
# Input: $name = "python", $typed = "perl"
# Output: false
#
# Example 4
# Input: $name = "coffeescript", $typed = "cofffeescccript"
# Output: true

use strict;
use warnings;

my $name = "perl";
my $typed = "perrrl";
broken_keyboard($name, $typed);

$name = "raku"; $typed = "rrakuuuu";
broken_keyboard($name, $typed);

$name = "python"; $typed = "perl";
broken_keyboard($name, $typed);

$name = "coffeescript"; $typed = "cofffeescccript";
broken_keyboard($name, $typed);

exit 0;

sub broken_keyboard {
    my $name = shift;
    my $typed = shift;

    my %cnt;
    foreach (split //, $name) {
        $cnt{$_}++;
    }
    foreach (split //, $typed) {
        $cnt{$_}--
            if defined $cnt{$_};
    }

    printf "name '%s' typed '%s' -> %s\n",
        $name, $typed, 
        ( scalar map { $_ < 0 ? $_ : () }
                   values %cnt
        ) ? 'true'
          : 'false';
}
