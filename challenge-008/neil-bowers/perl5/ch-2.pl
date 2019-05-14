#!/usr/bin/perl

use strict;
use warnings;

print center("This", "is", "a test of the", "center function"), "\n";

sub center
{
    my @strings = @_;

    my $max_length;
    foreach my $string (@strings) {
        $max_length = length($string) if !defined($max_length) || length($string) > $max_length;
    }

    return map { (' ' x (($max_length - length($_))/2)).$_ } @strings;
}
