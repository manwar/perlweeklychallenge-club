#!/usr/bin/perl
use strict;
use warnings;

# Why reinvent the wheel?
use String::Pad qw(pad);

# $res = pad($text | \@texts, $width [, $which [, $padchar=' ' [, $truncate=0] ] ] );

# parameter $text | \@texts: str or arrayref

# parameter $which is either "r" or "right" for padding on the right (the default if
# not specified), "l" or "left" for padding on the right, or "c" or "center" or "centre"
# for left+right padding to center the text. Note that "r" will mean "left justified",
# while "l" will mean "right justified.

# Tests

my ($str, $w) = ("", 0);

# Example 1
# printf "%s\n", pad(("Hi", 5)[0], ("Hi", 5)[1], "c", "*"); ...clever but why...
# so:

($str, $w) = ("Hi", 5);
printf "%s\n", pad($str, $w, "c", "*"); # Output: "*Hi**"


# Example 2
($str, $w) = ("Code", 10);
printf "%s\n", pad($str, $w, "c", "*"); # Output: "***Code***"

# Example 3
($str, $w) = ("Hello", 9);
printf "%s\n", pad($str, $w, "c", "*"); # Output: "**Hello**"

# Example 4
($str, $w) = ("Perl", 4);
printf "%s\n", pad($str, $w, "c", "*"); # Output: "Perl"

# Example 5
($str, $w) = ("A", 7);
printf "%s\n", pad($str, $w, "c", "*"); # Output: "***A***"

# Example 6
($str, $w) = ("", 5);
printf "%s\n", pad($str, $w, "c", "*"); # Output: "*****"
