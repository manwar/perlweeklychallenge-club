#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

# Get the size of the matrix
die("Please provide matrix size") if @ARGV != 1;
my $size = $ARGV[0];
die("Size must be an integer") if int($size) != $size;
die("Size must be >= 1") if $size < 1;

for ( my $row = 0; $row < $size; $row++ ) {
    my (@row) = map { 0 } 1 .. $size;
    $row[$row] = 1;
    say join " ", @row;
}
