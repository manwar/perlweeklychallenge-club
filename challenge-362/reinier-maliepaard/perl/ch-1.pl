#!/usr/bin/perl
use strict;
use warnings;

# My first approach: for-loop and substr!
# My second approach: map, substr and join.

# About the for-loop
# - The loop structure is intuitive for those new to programming,
#   or for those with a background in C, Lisp, PHP, Javascript (as I have)
# - Debugging is easier since you can step through each iteration
#   and inspect variables directly# Debugging is easier since you
#   can step through each iteration and inspect variables directly

# About map and join
# - This approach is more declarative, focusing on what you
#   want to achieve rather than how to iterate.
# - It eliminates manual string concatenation, avoiding
#   repetitive operations like .=
# - The data flow is clear: transform a list, then join it
#   into a string.

# for-loop version
sub echo_chamber {
    my $str = shift;
    my $result = "";

    for ($i = 0; $i < length($abc); $i++) {
        $result .= ( substr($abc, $i, 1) ) x ($i + 1);
    }

    return $result;
}

# map version
# sub echo_chamber {
#     my $str = shift;

#     my $result = join '', map { substr($str, $_, 1) x ($_ + 1) } 0 .. (length($str) - 1);
#     return $result;
# }


# Tests
my $str;

# Example 1
$str = "abca";
printf "%s\n", echo_chamber($str); # Output: "abbcccaaaa"

# Example 2
$str = "xyz";
printf "%s\n", echo_chamber($str); # Output: "xyyzzz"

# Example 3
$str = "code";
printf "%s\n", echo_chamber($str); # Output: "coodddeeee"

# Example 4
$str = "hello";
printf "%s\n", echo_chamber($str); # Output: "heelllllllooooo"

# Example 5
$str = "a";
printf "%s\n", echo_chamber($str); # Output: "a"
