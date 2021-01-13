use v6;


# Rotate Matrix
# Write a script to rotate the followin matrix by given 90/180/270 degrees clockwise.

# [ 1, 2, 3 ]
# [ 4, 5, 6 ]
# [ 7, 8, 9 ]
# For example, if you rotate by 90 degrees then expected result should be like below

# [ 7, 4, 1 ]
# [ 8, 5, 2 ]
# [ 9, 6, 3 ]

sub MAIN ( ) {    
    my @aMatrix = ([1,2,3],[4,5,6],[7,8,9]);
    say "Matrix";
    drawMatrix( @aMatrix );
    
    
    my @aMatrixRotated90 = rotateMatrix(@aMatrix, 90);
    say "Matrix rotated 90 degrees clockwise";
    drawMatrix(@aMatrixRotated90);
    
    
    my @aMatrixRotated180 = rotateMatrix(@aMatrix, 180);
    say "Matrix rotated 180 degrees clockwise";
    drawMatrix(@aMatrixRotated180);
    
    my @aMatrixRotated270 = rotateMatrix(@aMatrix, 270);
    say "Matrix rotated 270 degrees clockwise";
    drawMatrix(@aMatrixRotated270);
}

sub rotateMatrix (  @aMatrix , $degrees ) {
    my @aMatrixRotating = @aMatrix;
    my $degreesLeft = $degrees;
    while ( $degreesLeft / 90 >= 1  ) {
        @aMatrixRotating = rotateMatrix90Degrees(@aMatrixRotating );
        $degreesLeft -= 90;
    }
    return @aMatrixRotating;
}


sub rotateMatrix90Degrees ( @aMatrix ) {
    my @aNewMatrix = () ;
    for ( 0..@aMatrix.end ) -> $x {
        for (0..@aMatrix[$x].end ) -> $y {
            my $newY =  @aMatrix.end - $x;
            @aNewMatrix[$y][$newY]  = @aMatrix[$x][$y]  ;
        }
    }
    return @aNewMatrix;
}


sub drawMatrix (  @aMatrix  ) { 
    for @aMatrix -> @row {
        say "[ " ~ @row.join(', ') ~ "]";
    }
}


