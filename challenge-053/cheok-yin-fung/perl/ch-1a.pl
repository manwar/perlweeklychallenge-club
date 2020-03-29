#!/usr/bin/perl
use strict;
use xy; #upload the module with the perl script

# Perl Weekly Challenge #053 Task #1
# 90/180/270 degree clockwise Rotation of a N x N square matrix
# Usage(example): put the module in proper place, then:
#                 $ ch-1a.pl 3 90 1 2 3 4 5 6 7 8 9

my $N = shift @ARGV;

my $ANGLE = shift @ARGV;

my $hN = $N/2 + 0.5;

my @temp = (-$hN, -$hN); 
my $T = \@temp;


sub translation_add_negT {
    $_[0] -= $T->[0];
    $_[1] -= $T->[1];
    return ($_[0], $_[1])
}

sub translation_add_T {
    $_[0] += $T->[0];
    $_[1] += $T->[1];
    return ($_[0], $_[1])
}


sub rcaqx {  #short for  Rotation_Clockwise_A_Quarter, x stands for multiple
    if ($_[2]>=1) {
        my ($xcoord, $ycoord) = ($_[0], $_[1]);
        $_[0] = $ycoord;
        $_[1] = -$xcoord;
        return rcaqx($_[0], $_[1], $_[2]-1);
    } else {return ($_[0], $_[1])}
}

my $xcoord = 0;
my $ycoord = $N;
my $i = 0;
my $matrix;
foreach (@ARGV) {
    $i++;
    $xcoord++;
    $matrix->[$i] = xy->new($_, $xcoord, $ycoord);
    if ($xcoord == $N) {
        $ycoord--; 
        $xcoord=0;
    }
}

die "Not a square matrix" unless $i==$N*$N;

my $newmatrix;

my @coordinateplane;

sub position {
    return $_[0] + $N*($N-$_[1]) - 1
}

for $i (1..$N*$N) {
    $newmatrix->[$i] = xy->new($matrix->[$i]->value, 
        translation_add_negT(rcaqx ((translation_add_T(
                        $matrix->[$i]->x, $matrix->[$i]->y) ), $ANGLE/90 )) );

    $coordinateplane[position( $newmatrix->[$i]->x, $newmatrix->[$i]->y )] 
         = $newmatrix->[$i]->value;
}


for (0..$N*$N-1) {
    if ($_ % $N == 0) {print "\n"};
    printf "%3d " , $coordinateplane[$_];
}

# ref: https://en.wikipedia.org/wiki/Rotation_matrix

# For N=3, the coordinates and the corresponding index of @coordinateplane:
# (1,3) (2,3) (3,3)     0, 1, 2
# (1,2) (2,2) (3,2)     3, 4, 5
# (1,1) (2,1) (3,1)     6, 7, 8

# For N=5, the coordinates are:
# (1,5) (2,5) (3,5) (4,5) (5,5)
# (1,4) (2,4) (3,4) (4,4) (5,4)
# (1,3) (2,3) (3,3) (4,3) (5,3)
# (1,2) (2,2) (3,2) (4,2) (5,2)
# (1,1) (2,1) (3,1) (4,1) (5,1)
