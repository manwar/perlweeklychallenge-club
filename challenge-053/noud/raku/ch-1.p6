# Rotate Matrix
#
# Write a script to rotate the followin matrix by given 90/180/270 degrees
# clockwise.
#
# [ 1, 2, 3 ]
# [ 4, 5, 6 ]
# [ 7, 8, 9 ]
#
# For example, if you rotate by 90 degrees then expected result should be like
# below
#
# [ 7, 4, 1 ]
# [ 8, 5, 2 ]
# [ 9, 6, 3 ]

sub print-matrix(@N) {
    say $_ for @N;
}

# Flip matrix in diagonal
sub diag-flip(@N) {
    for 0..^@N.elems -> $i {
        for 0..^$i -> $j {
            my $t = @N[$i][$j];
            @N[$i][$j] = @N[$j][$i];
            @N[$j][$i] = $t;
        }
    }
    @N;
}

# Flip matrix horizontal
sub horz-flip(@N) {
    for 0..^@N.elems -> $i {
        for 0..^(@N.elems / 2) -> $j {
            my $t = @N[$i][$j];
            @N[$i][$j] = @N[$i][@N.elems - $j - 1];
            @N[$i][@N.elems - $j - 1] = $t;
        }
    }
    @N;
}

# The horizontal and diagonal flip together generate the full symmetry group of
# the square, also called the Octic group D4. Rotating 90 degrees is a symmetry
# of the square (or matrix). Therefore we can find a combination of horizontal
# and diagonal flipping that's equal to rotating 90 degrees.
sub rotate90(@N) {
    horz-flip(diag-flip(@N));
}

sub rotate180(@N) {
    rotate90(rotate90(@N));
}

sub rotate270(@N) {
    rotate90(rotate180(@N));
}


my @M = [[1, 2, 3],
         [4, 5, 6],
         [7, 8, 9]];

say 'Original matrix:';
print-matrix(@M);
say 'Rotate 90 degrees:';
print-matrix(rotate90(@M));
say 'Rotate 180 degrees:';
print-matrix(rotate90(@M));
say 'Rotate 270 degrees:';
print-matrix(rotate90(@M));
