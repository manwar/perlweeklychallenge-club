#!/usr/bin/perl

# Challenge 008
#
# Challenge #2
# Write a function, ‘center’, whose argument is a list of strings, which will
# be lines of text. The function should insert spaces at the beginning of the
# lines of text so that if they were printed, the text would be centered, and
# return the modified lines.

use strict;
use warnings;
use 5.030;

sub center {
    my(@lines) = @_;
    my $max_len = max(map {length($_)} @lines);
    @lines = map {$_ = " " x (($max_len-length($_))/2) . $_} @lines;
    return @lines;
}

sub max {
    my($max, @a) = @_;
    for (@a) {
        $max = $_ if $max < $_;
    }
    return $max;
}


my @lines = center(@ARGV);
say join "\n", @lines;
