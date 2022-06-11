#!perl.exe

use strict;
use warnings;
use List::Util qw/min max/;
use feature qw/say/;

# Author: Robert DiCicco
# Date: 14-FEB-2022
# Challenge #151 Rectangle Area (Perl)

# get area of rectangle
sub area {
    my $box  = $_[0];
    my $xval = abs( @$box[0] ) + abs( @$box[2] );
    my $yval = abs( @$box[1] ) + abs( @$box[3] );
    return ( $xval * $yval );
}

# get area of overlapping rectangle
sub overlap {
    my $r1      = $_[0];
    my $r2      = $_[1];
    my $x_dist  = ( min( @$r1[2], @$r2[2] ) - max( @$r1[0], @$r2[0] ) );
    my $y_dist  = ( min( @$r1[3], @$r2[3] ) - max( @$r1[1], @$r2[1] ) );
    my $overlap = 0;

    if ( $x_dist > 0 and $y_dist > 0 ) {
        $overlap = $x_dist * $y_dist;
    }

    return $overlap;
}

my @rec1 = ( ( -3, -1 ), ( 1, 3 ) );
my @rec2 = ( ( -1, -3 ), ( 2, 2 ) );

# my @rec1 = ((-1,0), (2,2));
# my @rec2 = ((0,-1), (4,4));
my $a = area( \@rec1 );
my $b = area( \@rec2 );

print "($rec1[0],$rec1[1]),($rec1[2],$rec1[3]) Area = $a\n";
print "($rec2[0],$rec2[1]),($rec2[2],$rec2[3]) Area = $b\n";
my $ov = overlap( \@rec1, \@rec2 );

print "Overlap Area = $ov\n";

my $total = $a + $b - $ov;

print "Total Area = $a + $b - $ov = $total\n";
