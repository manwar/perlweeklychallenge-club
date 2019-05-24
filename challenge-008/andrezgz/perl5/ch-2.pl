#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-008/
# Challenge #2
# Write a function, 'center', whose argument is a list of strings, which will be lines of text.
# The function should insert spaces at the beginning of the lines of text so that if they were printed,
# the text would be centered, and return the modified lines.

use strict;
use warnings;

print join $/, center("This", "is", "a test of the", "center function");

sub center {
    my @lines = @_;
    my $max = 0;
    map { $max = length($_) if (length($_) > $max) } @lines;
    return map { ' 'x(($max-length($_))/2).$_ } @lines
}
