#!/usr/bin/env perl

# Write a script that can wrap the given paragraph at a specified column using
# the greedy algorithm:
# https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_number_of_lines

use 5.026;
use strict;
use warnings;

my $width = shift
    or die "usage: $0 WIDTH\n";

$width =~ /^\d+$/
    or die "The WIDTH argument must be a number, not '$width'\n";

# Read by paragraphs
local $/ = '';

while (<>) {
    chomp;
    my ($line, @words) = split;
    foreach my $word (@words) {
        if (length($line) + 1 + length($word) <= $width) {
            $line .= " $word";
        } else {
            say $line;
            $line = $word;
        }
    }
    say "$line\n" if length($line);
}
