#!/usr/bin/env perl

# Challenge 312
#
# Task 1: Minimum Time
# Submitted by: Mohammad Sajid Anwar
#
# You are given a typewriter with lowercase english letters a to z arranged
# in a circle.
#
# Task 1
#
# Typing a character takes 1 sec. You can move pointer one character clockwise
# or anti-clockwise.
#
# The pointer initially points at a.
#
# Write a script to return minimum time it takes to print the given string.
# Example 1
#
# Input: $str = "abc"
# Output: 5
#
# The pointer is at 'a' initially.
# 1 sec - type the letter 'a'
# 1 sec - move pointer clockwise to 'b'
# 1 sec - type the letter 'b'
# 1 sec - move pointer clockwise to 'c'
# 1 sec - type the letter 'c'
#
# Example 2
#
# Input: $str = "bza"
# Output: 7
#
# The pointer is at 'a' initially.
# 1 sec - move pointer clockwise to 'b'
# 1 sec - type the letter 'b'
# 1 sec - move pointer anti-clockwise to 'a'
# 1 sec - move pointer anti-clockwise to 'z'
# 1 sec - type the letter 'z'
# 1 sec - move pointer clockwise to 'a'
# 1 sec - type the letter 'a'
#
# Example 3
#
# Input: $str = "zjpc"
# Output: 34

use Modern::Perl;

my $string = shift // "";
say steps_to_type($string);

sub steps_to_type {
    my($string) = @_;
    my $wheel = join "", 'a'..'z';

    my $steps = 0;
    while ($string ne "") {
        my $letter = substr($string, 0, 1);
        $string = substr($string, 1);

        # scan
        (my $num_steps, $wheel) = scan_letter($wheel, $letter);
        $steps += $num_steps;

        # type
        $steps++;
    }

    return $steps;
}

sub scan_letter {
    my($wheel, $letter) = @_;
    my $pos = -1;
    $wheel =~ /$letter/gc and $pos = pos($wheel)-1;
    $pos >= 0 or die;
    if ($pos == 0) {
        return ($pos, $wheel);
    }
    elsif ($pos < length($wheel)/2) {
        $wheel = substr($wheel, $pos).substr($wheel, 0, $pos);
        return ($pos, $wheel);
    }
    else {
        $wheel = substr($wheel, $pos).substr($wheel, 0, $pos);
        return (length($wheel)-$pos, $wheel);
    }
}
