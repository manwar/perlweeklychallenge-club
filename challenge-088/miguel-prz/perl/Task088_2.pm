use strict;
use warnings;

#------------------------------------------------------------------------------

=pod

Surround the array and consider:
* 1: node was visited
* 0: node has to be visited

Example 6x4 matrix => converted to 8x6 (matrix_aux)

1 1 1 1 1 1
1 0 0 0 0 1
1 0 0 0 0 1
1 0 0 0 0 1
1 0 0 0 0 1
1 0 0 0 0 1
1 0 0 0 0 1
1 1 1 1 1 1

Algorithm idea: 
- move in the current direction, visiting "0" nodes
- change "0" node by "1"
- when "1" node is reached, go back and change direction
- if all nodes are visited, end

=cut

#------------------------------------------------------------------------------

sub spiral_matrix {
    my @matrix = @_;
    my $aux_matrix = [];
    my @result = ();

    my $size_x = scalar $matrix[0]->@*;
    my $size_y = scalar @matrix;
    my $nodes = $size_x * $size_y;

    push $aux_matrix->@*, [ (1) x ($size_x+2)   ];
    push $aux_matrix->@*, [ 1, (0) x $size_x, 1 ] for ( 1 .. $size_y );
    push $aux_matrix->@*, [ (1)  x ($size_x+2)  ];
    
    my $direction = 0;
    my $visits = 0;
    my ($cx, $cx_1) = (0, 0);
    my ($cy, $cy_1) = (1, 1);
    
    while( $visits < $nodes ) {

        $direction == 0 && $cx++;
        $direction == 1 && $cy++;
        $direction == 2 && $cx--;
        $direction == 3 && $cy--;

        if( $aux_matrix->[$cy][$cx] ) {
            $direction = ++$direction % 4;
            ($cx, $cy) = ($cx_1, $cy_1);
        }
        else {
            $aux_matrix->[$cy][$cx] = 1;
            ($cx_1, $cy_1) = ($cx, $cy);
            push @result, $matrix[$cy-1][$cx-1];
            $visits++;
        }
    }
    return @result;
}

#------------------------------------------------------------------------------

1970;
