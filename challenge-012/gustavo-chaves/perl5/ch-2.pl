#!/usr/bin/env perl

# Write a script that finds the common directory path, given a collection of
# paths and directory separator. For example, if the following paths are
# supplied.

use 5.026;
use strict;
use autodie;
use warnings;

my $separator = shift
    or die "Usage: $0 CHAR\n";

chomp(my $path = <>);
my @prefix = split $separator, $path;

while (<>) {
    chomp;
    my @path = split $separator;
    my $min = @prefix < @path ? @prefix : @path;
    my $i=0;
    while ($i<$min && $prefix[$i] eq $path[$i]) {
        ++$i;
    }
    splice @prefix, $i;
}

say join($separator, @prefix);
