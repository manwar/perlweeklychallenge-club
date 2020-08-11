#! /opt/local/bin/perl
#
#       mean_angles.pl
#
#       task: Create a script that prints mean angles of the given list of angles in degrees.
#
#       usage: mean_angles.pl angle1 angle2 angle3
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

use List::Util qw( reduce );

my $pi = 3.14159265358979;

## ## ## ## ## MAIN

## the angles are fed to the program in degrees, but Perl's trig functions want radians
my @angles = map { deg2rad($_) } @ARGV;

## first  we convert to polar, r->(cos r, sin r)
## summing and dividing the coordinates to provide the average
## then use atan2(y,x) to get the result in radians

## this works well:
# my ($sumx, $sumy);
# for my $angle ( @angles ) {
#   $sumx += cos $angle;
#   $sumy += sin $angle;
# }
# my $v_avg = atan2( $sumy/(scalar @angles), $sumx/(scalar @angles) );

## but I like this more:
my $x = (reduce {$a + cos $b} 0, @angles) / scalar @angles;
my $y = (reduce {$a + sin $b} 0, @angles) / scalar @angles;
my $v_avg = atan2( $y, $x );

## convert back to degrees
say rad2deg( $v_avg );



## ## ## ## ## SUBS

sub deg2rad {
    return ($_[0]/180) * $pi;
}

sub rad2deg {
    return ($_[0]/$pi) * 180;
}


