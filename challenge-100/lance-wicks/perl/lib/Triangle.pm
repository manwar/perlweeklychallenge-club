package Triangle;

use Moo;

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

sub min_path_sum {
    my ( $self, $triangle ) = @_;

    my $table = $self->triangle_to_table($triangle);
    my $sum   = $self->parse_table($table);

    return $sum;
}

sub triangle_to_table {
    my ( $self, $triangle ) = @_;

    my $max = @$triangle - 1;
    for my $row_index ( 0 .. $max ) {
        for my $column_index ( 0 .. $max ) {
            $triangle->[$row_index][$column_index] //= 0;
        }
    }

    return $triangle;
}

sub parse_table {
    my ( $self, $table ) = @_;

    my $max = @$table - 1;

    for my $row_index ( reverse( 0 .. $max - 1 ) ) {
        for my $column_index ( 0 .. $max - 1 ) {
            if ( $table->[ $row_index + 1 ][$column_index]
                < $table->[ $row_index + 1 ][ $column_index + 1 ] )
            {
                $table->[$row_index][$column_index]
                    += $table->[ $row_index + 1 ][$column_index];
            }
            else {
                $table->[$row_index][$column_index]
                    += $table->[ $row_index + 1 ][ $column_index + 1 ];
            }

        }
    }

    return $table->[0][0];
}

1;
