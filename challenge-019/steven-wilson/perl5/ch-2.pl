#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-30
# Week: 019
#
# Task #2
# Write a script that can wrap the given paragraph at a specified column
# using the greedy algorithm.

use strict;
use warnings;

my $text = "I saw the best minds of my generation destroyed by madness,
starving hysterical naked, dragging themselves through the negro streets
at dawn looking for an angry fix, Angel-headed hipsters burning for the
ancient heavenly connection to the starry dynamo in the machinery of
night,";

$text =~ s/\R/ /g;

print "specify a column width: ";
chomp( my $line_width = <> );

my @words = split / /, $text;

my $space_left = $line_width;

for my $word (@words) {
    if ( ( ( length $word ) + 1 ) > $space_left ) {
        print "\n$word ";
        $space_left = $line_width - length $word;
    }
    else {
        print "$word ";
        $space_left -= ( ( length $word ) + 1 );
    }
}
print "\n";
