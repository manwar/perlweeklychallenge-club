#!/usr/bin/env perl
use v5.16;
use strict;
use warnings;

die "Only one argument allowed" if @ARGV > 1;
my $max = @ARGV ? int( +$ARGV[0] ) : 11;    # Default to 11
die "Max must be >= 1" if $max < 1;

my $maxlen  = length $max;
my $prodlen = length( $max * $max );

# Header line
printf( "%" . ( $maxlen + 1 ) . "s|", "x" );
for my $i ( 1 .. $max ) {
    printf( "%" . ( $prodlen + 1 ) . "d", $i );
}
print "\n";

# Seperator line
say "-" x ( $maxlen + 1 ) . "+" . "-" x ( $max * ( $prodlen + 1 ) );

for my $i ( 1 .. $max ) {
    # New row
    printf( "%" . ( $maxlen + 1 ) . "d|", $i );

    for my $j ( 1 .. $max ) {
        if ( $i <= $j ) {
            printf( "%" . ( $prodlen + 1 ) . "d", $i * $j );
        } else {
            print " " x ( $prodlen + 1 );
        }
    }
    print "\n";
}
