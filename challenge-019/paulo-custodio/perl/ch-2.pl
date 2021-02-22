#!/usr/bin/perl

# Challenge 019
#
# Task #2
# Write a script that can wrap the given paragraph at a specified column using the greedy algorithm.

use strict;
use warnings;
use 5.030;

my $text = "";
while (<>) {
    $text .= $_;
}
print wrap($text, 72);


sub wrap {
    my($text, $column) = @_;
    $column ||= 72;

    my $output = "";
    my $sep = "";
    my $pos = 0;
    for my $word (split(' ', $text)) {
        if ($pos + length($sep) + length($word) >= $column) {
            $output .= "\n";
            $sep = "";
            $pos = 0;
        }
        $output .= $sep . $word;
        $pos += length($sep) + length($word);
        $sep = " ";
    }
    $output .= "\n";
    return $output;
}
