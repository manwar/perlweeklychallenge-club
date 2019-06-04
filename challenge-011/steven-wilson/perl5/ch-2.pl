#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-03
# Week: 011
# Challenge: #2
#
# Write a script to create an Indentity Matrix for the given size. For
# example, if the size is 4, then create Identity Matrix 4x4. For more
# information about Indentity Matrix, please read the wiki page.
# https://en.wikipedia.org/wiki/Identity_matrix

use strict;
use warnings;
use feature qw / say /;

print "Create an Indentity Matrix of size: ";

chomp( my $size_of_matrix = <> );

my @matrix = create_identity_matrix($size_of_matrix);
print_matrix( \@matrix );

sub create_identity_matrix {
    my $size_of_matrix = shift;
    my @matrix;
    for ( my $i = 0; $i < $size_of_matrix; $i++ ) {
        $matrix[$i] = [ (0) x $size_of_matrix ];
        $matrix[$i][$i] = 1;
    }
    return @matrix;
}

sub print_matrix {
    my $matrix_ref = shift;
    my @matrix     = @{$matrix_ref};
    for (@matrix) {
        say "@{$_}";
    }
}
