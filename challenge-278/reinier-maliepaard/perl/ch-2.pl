#!/usr/bin/perl
use strict;
use warnings;

sub reverse_word {

    my $index = index($_[0], $_[1]);

    return(join("", sort( split(//, substr($_[0], 0, $index + 1)) ),
                    substr($_[0], $index + 1), "\n"));
}

# TESTS

my $str;
my $char;

# Example 1
$str = "challenge";
$char = "e";
print(reverse_word($str, $char), "\n"); # Output: "acehllnge"

# Example 2
$str = "programming";
$char = "a";
print(reverse_word($str, $char), "\n"); # Output: "agoprrmming"

# Example 3
$str = "champion";
$char = "b";
print(reverse_word($str, $char), "\n"); # Output: "champion"
