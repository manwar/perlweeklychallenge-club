#!/usr/bin/perl

use strict;
use warnings;

sub generate_pascal_triangle {
    my $rows     = shift;
    my @triangle = ();
    for my $i ( 0 .. $rows - 1 ) {
        my @row = (1);
        for my $j ( 1 .. $i ) {
            push @row, $triangle[ $i - 1 ][ $j - 1 ] + ( $triangle[ $i - 1 ][$j] // 0 );
        }
        push @row,      1;
        push @triangle, \@row;
    }
    return @triangle;
}

my $rows = shift || 3;
if ( $rows < 3 ) {
    die "Error: Pascal's Triangle must have at least 3 rows\n";
}
my @triangle = generate_pascal_triangle($rows);

print "Pascal's Triangle with $rows rows:\n";
for my $i ( 0 .. $rows - 1 ) {
    my $padding = " " x ( $rows - $i - 1 );
    print "$padding", join( " ", @{ $triangle[$i] } ), "\n";
}
