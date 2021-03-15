#!/usr/bin/perl

# Challenge 011
#
# Challenge #2
# Write a script to create an Indentity Matrix for the given size. For example,
# if the size is 4, then create Identity Matrix 4x4. For more information about
# Indentity Matrix, please read the wiki page.

use strict;
use warnings;
use 5.030;

my $size = shift || 4;
my @i;
for my $r (0..$size-1) {
    for my $c (0..$size-1) {
        $i[$r][$c] = ($r==$c) ? 1 : 0;
    }
}

# print matrix
say "[", join("\n ", map {"[".join(", ", @{$i[$_]})."]"} 0..$size-1), "]";
