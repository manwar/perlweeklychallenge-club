#!/usr/bin/perl
use strict;
use warnings;

sub twice_appearance {

    my %found = ();

    foreach my $char ( split(//, $_[0]) ) {
        return($char) if ($found{$char});
        $found{$char} = 1;
    }
    # return -1 if no duplicate is found
    return(-1);
}

# Tests

my $str;

# Example 1
$str = "acbddbca";
print(twice_appearance($str), "\n"); # Output: "d"

# Example 2
$str = "abccd";
print(twice_appearance($str), "\n"); # Output: "c"

# Example 3
$str = "abcdabbb";
print(twice_appearance($str), "\n"); # Output: "a"

# Study: https://reiniermaliepaard.nl/perl/part-2/index.php?id=useful_hash
