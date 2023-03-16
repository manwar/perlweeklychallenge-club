#!/usr/bin/perl
use strict;
use warnings;

my $size = 4;    # change this to the desired size
my @identity_matrix;

for my $i ( 0 .. $size - 1 ) {
    for my $j ( 0 .. $size - 1 ) {
        if ( $i == $j ) {
            $identity_matrix[$i][$j] = 1;
        }
        else {
            $identity_matrix[$i][$j] = 0;
        }
    }
}

# print the identity matrix
for my $row (@identity_matrix) {
    print "@$row\n";
}
