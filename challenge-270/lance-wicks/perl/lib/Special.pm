package Special;

use Data::Dumper;

# A position (i, j) is called special if
#   $matrix[i][j] == 1
#    and all other elements in the row i
#    and column j are 0.

sub count_positions {
    my ( $self, $matrix ) = @_;

    my $positions = 0;
    for ( @{ $self->coords_list } ) {

        $positions++ if $self->is_special( $matrix, $_->[0], $_->[1], );
    }

    return $positions;
}

sub coords_list {
    return [
        [ 0, 0 ], [ 0, 1 ], [ 0, 2 ],    #
        [ 1, 0 ], [ 1, 1 ], [ 1, 2 ],    #
        [ 2, 0 ], [ 2, 1 ], [ 2, 2 ],    #
    ];
}

sub is_special {
    my ( $self, $matrix_orig, $i, $j ) = @_;

    my $matrix;
    for ( 0, 1, 2 ) {
        push @$matrix, [ @{ $matrix_orig->[$_] } ];
    }

    return 0 if $matrix->[$i][$j] == 0;

    my $row = $matrix->[$i];
    delete $row->[$j];

    my $result = grep { $_ != 0 } @$row;
    return 0 if $result;

    my @column;
    for ( 0, 1, 2 ) {
        push @column, $matrix->[$_][$j];
    }
    delete $column[$i];

    $result = grep { $_ != 0 } @column;
    return 0 if $result;

    return 1;
}

1;
