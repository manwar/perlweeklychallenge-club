#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw/ max /;

print center("This", "is", "a test of the", "center function"), "\n";

sub center
{
    my @strings    = @_;
    my $max_length = max map { length($_) } @strings;

    return map { (' ' x (($max_length - length($_))/2)).$_ } @strings;
}
