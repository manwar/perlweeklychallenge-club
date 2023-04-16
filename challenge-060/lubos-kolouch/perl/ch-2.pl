#!/usr/bin/perl
use strict;
use warnings;

sub generate_numbers {
    my ( $list, $x, $y, $current ) = @_;
    if ( $x == 0 ) {
        return int($current) < $y ? ( int($current) ) : ();
    }
    my @result;
    for my $num (@$list) {
        push @result, generate_numbers( $list, $x - 1, $y, $current . $num );
    }
    return @result;
}

my @L = ( 0, 1, 2, 5 );
my $X = 2;
my $Y = 21;

my @output = generate_numbers( \@L, $X, $Y, "" );
print join( ", ", @output ), "\n";
