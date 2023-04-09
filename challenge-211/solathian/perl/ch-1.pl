#!usr/bin/perl
use v5.36;

use builtin qw(indexed true false);
no warnings 'experimental';

# Challenge 211- 1 - Toeplitz Matrix
# You are given a matrix m x n.

# Write a script to find out if the given matrix is Toeplitz Matrix.


my  @matrix = ( [4, 3, 2, 1],
                [5, 4, 3, 2],
                [6, 5, 4, 3]);
                
Toeplitz(\@matrix);  # Output: true

my  @matrix2 = ( [1, 2, 3],
                 [3, 2, 1]);
            
Toeplitz(\@matrix2);  # Output: true



sub Toeplitz($matrixRef)
{
    my $retVal = true;
    
    OUTER:
    foreach my ($i, $row) (indexed @$matrixRef)
    {
        foreach my ($j, $jVal) (indexed @$row)
        {
            # skip the elements in the last column and the row, since we cannot check diagonally
            next if($i == $#$matrixRef);
            next if($j == $#$row);
            
            if($matrixRef->[$i][$j] !=  $matrixRef->[$i + 1][$j + 1] )
            {
                $retVal = false;
                last OUTER;
            }

        }
    }
    
    if($retVal){ say "true"  }
    else{        say "false" }


}