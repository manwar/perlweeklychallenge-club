#!/usr/bin/perl
use strict;

# Perl Weekly Challenge #053 Task #1
# Usage : ch-1.pl [the ANGLE, 90's multiples] 1 2 3 4 5 6 7 8 9
# Example Input : ch-1.pl 90 1 2 3 4 5 6 7 8 9
# Example Output:   
# 7 4 1
# 8 5 2
# 9 6 3

my $ANGLE = shift @ARGV;

my @cp = ( #short for coordinateplane
    3,  2,  1, 
    4, -1,  0, 
    5,  6,  7); 
# contrast with the natural array 3x3->9 
#  0  1  2
#  3  4  5
#  6  7  8

my %hash;
foreach (1..9) {
    if ($_>=0) {$hash{$cp[$_-1]} = $ARGV[$_-1];}
}
$hash{-1} = @ARGV[4];


sub rcaqx {  #short for  Rotation_Clockwise_A_Quarter, x for multiple
    if ($_[0]>=1) {
        my %nhash;
        for (0..8) {
            if ( $cp[$_] >= 0 ) {
                $nhash{ $cp[$_] } = $hash{ ($cp[($_ )]+2) % 8 };
            }
        }
        $nhash{-1} = $hash{-1};
        %hash = %nhash;
        rcaqx($_[0]-1);
    }
}

rcaqx($ANGLE/90);


for (0..8) {
    print "\n" if $_ % 3 == 0;
    if ($cp[$_] != -1) {
        print $hash{$cp[$_]}, " ";
    } else {
        print $hash{-1}," ";
    }
}

