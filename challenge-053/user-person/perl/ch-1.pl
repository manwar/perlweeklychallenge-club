#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/         #
#                                                                         #
# Rotate Matrix                                                           #
# Write a script to rotate the followin matrix by given 90/180/270        #
# degrees clockwise.                                                      #
#                                                                         #
# [ 1, 2, 3 ]                                                             #
# [ 4, 5, 6 ]                                                             #
# [ 7, 8, 9 ]                                                             #
#                                                                         #
# For example, if you rotate by 90 degrees then expected result should    #
# be like below                                                           #
#                                                                         #
# [ 7, 4, 1 ]                                                             #
# [ 8, 5, 2 ]                                                             #
# [ 9, 6, 3 ]                                                             #
#                                                                         #
###########################################################################

use strict;
use warnings;
use diagnostics;

use FindBin;

sub flat {
    return map { ref eq 'ARRAY' ? flat(@$_) : $_ } @_;
}

my @matrix = [[1,2,3],
              [4,5,6],
              [7,8,9]];

#______________________________________
# 0 start  |   90   |   180  |   270  |
# 1 [0][0] | [0][2] | [2][2] | [2][0] |
# 2 [0][1] | [1][2] | [2][1] | [1][0] |
# 3 [0][2] | [2][2] | [2][0] | [0][0] |
# 4 [1][0] | [0][1] | [1][2] | [2][1] |
# 5 [1][1] | [1][1] | [1][1] | [1][1] |
# 6 [1][2] | [2][1] | [1][0] | [0][1] |
# 7 [2][0] | [0][0] | [0][2] | [2][2] |
# 8 [2][1] | [1][0] | [0][1] | [1][2] |
# 9 [2][2] | [2][0] | [0][0] | [0][2] |
#__________|________|________|________|

#     inner   outer
#   0 row 0 + col 0 +
#  90 col 2 - row 0 +
# 180 row 2 - col 2 -
# 270 col 2 - row 0 +

my $width = 0;
my @rawNums = ();

@rawNums = flat @matrix;

for (my $w=1; $w**2 <= scalar @rawNums; ++$w) {
    if ($w**2 == scalar @rawNums) {
        $width = $w;
    }
}

my $deg;
my $errorString = "Invalid choice. There are modes for 0, 90, 180, 270 degree rotations.\n";

if (@ARGV) {
    $deg = $ARGV[0];
} else {
    print STDERR $FindBin::Script, " requires a command-line argument. There are modes for 0, 90, 180, and 270 degree rotations.\n";
    exit(1);
}

if ($deg !~ m{\A[012789]+\Z}) {
    print STDERR $errorString;
    exit(1);
}

if ( not ($deg == 0 or $deg == 90 or $deg == 180 or $deg == 270)) {
    print STDERR $errorString;
    exit(1);
}

my @newMatrix = ();
my $i = 0;

if ($deg == 0) {

    for (my $j = 0; $j < $width; ++$j) {
        for (my $k = 0; $k < $width; ++$k) {
            $newMatrix[$j][$k] = $rawNums[$i++];
        }
    }

} elsif ( $deg == 90 ) {

    for (my $j = $width-1; $j >= 0; --$j) {
        for (my $k = 0; $k < $width; ++$k) {
            $newMatrix[$k][$j] = $rawNums[$i++];
        }
    }

} elsif ( $deg == 180 ) {

    for (my $j = $width-1; $j >= 0; --$j) {
        for (my $k = $width-1; $k >= 0; --$k) {
            $newMatrix[$j][$k] = $rawNums[$i++];
        }
    }

} elsif ( $deg == 270 ) {

    for (my $j = 0; $j < $width; ++$j) {
        for (my $k = $width-1; $k >= 0; --$k) {
            $newMatrix[$k][$j] = $rawNums[$i++];
        }
    }

}

foreach my $row (@newMatrix) {
    my $format = 0;
    foreach my $element (@$row) {
        if ($format == 0) {
            print "[", $element, ",";
        } elsif ($format == 1) {
            print " ", $element, ",";
        } elsif ($format == 2) {
            print " ", $element, "]";
        }
        ++$format;
    }

    print "\n";
}
