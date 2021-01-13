#!perl6
# Task 1 Challenge 053 Solution by kevincolyer
# Rotate Matrix
# Write a script to rotate the followin matrix by given 90/180/270 
# degrees clockwise.
# [ 1, 2, 3 ][ 4, 5, 6 ][ 7, 8, 9 ]For example, if you rotate by 
# 90 degrees then expected result should be like below
# [ 7, 4, 1 ][ 8, 5, 2 ][ 9, 6, 3 ]

sub rotateMatrix90(@matrix) {
    my @newMat;
    my $high=@matrix.elems;
    my $wide=@matrix[0].elems;
    @newMat.append: [] xx @matrix[0].elems;
    for ^@matrix.elems -> $row {
        for ^$wide -> $col {
            @newMat[$col][$row] = @matrix[$high-1-$row][$col];
        }
    }
    return @newMat;
}

sub rotateMatrix(@matrix is copy,$degrees is copy) {
    die "Can't rotate by $degrees" unless $degrees == any(90,180,270);
    while $degrees {
        $degrees-=90;
        @matrix=rotateMatrix90(@matrix);
    }
    return @matrix;
}

my @matrix=[1,2,3], [4,5,6], [7,8,9];
say "\nin:  " ~ @matrix.perl;
say "out: 90 " ~ rotateMatrix(@matrix,90).perl;
say "out: 180" ~ rotateMatrix(@matrix,180).perl;
say "out: 270" ~ rotateMatrix(@matrix,270).perl;
say "out: 271" ~ rotateMatrix(@matrix,271).perl;
