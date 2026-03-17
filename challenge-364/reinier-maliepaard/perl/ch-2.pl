#!/usr/bin/perl
use strict;
use warnings;

sub goal_parser {

    my $str = @_;

    $str =~ s/\(\)/o/g; # () -> o
    $str =~ s/[()]//g; # remove remaining parentheses

    return $str;
}

# Tests

my $str;

# Example 1
$str = "G()(al)";
printf "%s\n", goal_parser($str); # Output: "Goal"

# Example 2
$str = "G()()()()(al)";
printf "%s\n", goal_parser($str); # Output: "Gooooal"

# Example 3
$str = "(al)G(al)()()";
printf "%s\n", goal_parser($str); # Output: "alGaloo"

# Example 4
$str = "()G()G";
printf "%s\n", goal_parser($str); # Output: "oGoG"

# Example 5
$str = "(al)(al)G()()";
printf "%s\n", goal_parser($str); # Output: "alalGoo"
