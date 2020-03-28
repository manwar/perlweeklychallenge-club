#!perl6
# Task 1 Challenge 053 Solution by kevincolyer
# Rotate Matrix
# Write a script to rotate the followin matrix by given 90/180/270 
# degrees clockwise.
# [ 1, 2, 3 ][ 4, 5, 6 ][ 7, 8, 9 ]For example, if you rotate by 
# 90 degrees then expected result should be like below
# [ 7, 4, 1 ][ 8, 5, 2 ][ 9, 6, 3 ]

sub ArotateMatrix(@matrix,$deg) {
   say 'A: my @newMat=@matrix'; 
   my @newMat=@matrix;
    for ^@matrix.elems -> $row {
        for ^@matrix[0].elems -> $col {
            @newMat[$col][$row] = @matrix[$row][$col];
        }
    }
    return @newMat;
}

sub BrotateMatrix(@matrix,$deg) {
    say 'B: my @newMat=@matrix.clone'; 
    my @newMat=@matrix.clone;
    for ^@matrix.elems -> $row {
        for ^@matrix[0].elems -> $col {
            @newMat[$col][$row] = @matrix[$row][$col];
        }
    }
    return @newMat;
}

sub CrotateMatrix(@matrix is copy,$deg) {
    say 'C: my @newMat=@matrix.clone (called with @matrix is copy)'; 
    my @newMat=@matrix.clone;
    say @newMat.perl;
    for ^@matrix.elems -> $row {
        for ^@matrix[0].elems -> $col {            
            @newMat[$col][$row] = @matrix[$row][$col];
        }
    }
    return @newMat;
}
sub DrotateMatrix(@matrix,$deg) {
    say 'D: my @newMat; (rebuilt)'; 
    my @newMat;
    @newMat.append: [] xx @matrix[0].elems;
    for ^@matrix.elems -> $row {
        for ^@matrix[0].elems -> $col {
            @newMat[$col][$row] = @matrix[$row][$col];
        }
    }
    return @newMat;
}

my @matrix=[1,2,3], [4,5,6], [7,8,9];
say "\nin:  " ~ @matrix.perl;
say "out: " ~ ArotateMatrix(@matrix,90).perl;
say "org: " ~ @matrix.perl;
@matrix=[1,2,3], [4,5,6], [7,8,9];
say "\nin:  " ~ @matrix.perl;
say "out: " ~ BrotateMatrix(@matrix,90).perl;
say "org: " ~ @matrix.perl;
@matrix=[1,2,3], [4,5,6], [7,8,9];
say "\nin:  " ~ @matrix.perl;
say "out: " ~ CrotateMatrix(@matrix,90).perl;
say "org: " ~ @matrix.perl;
@matrix=[1,2,3], [4,5,6], [7,8,9];
say "\nin:  " ~ @matrix.perl;
say "out: " ~ DrotateMatrix(@matrix,90).perl;
say "org: " ~ @matrix.perl;
