use strict;
use warnings;

sub max_submatrix {
    my @matrix   = @_;
    my $max_area = 0;
    my ( $max_i, $max_j, $max_width, $max_height );

    for my $i ( 0 .. $#matrix ) {
        for my $j ( 0 .. $#{ $matrix[$i] } ) {
            next if $matrix[$i][$j] != 0;

            my $width  = 1;
            my $height = 1;

            while ($i + $height <= $#matrix
                && $matrix[ $i + $height ][$j] == 0 )
            {
                $height++;
            }

            while ( $j + $width <= $#{ $matrix[$i] }
                && all_zeros( \@matrix, $i, $j, $height, $width ) )
            {
                $width++;
            }

            my $area = $width * $height;

            if ( $area > $max_area ) {
                $max_area = $area;
                ( $max_i, $max_j, $max_width, $max_height ) =
                  ( $i, $j, $width, $height );
            }
        }
    }

    return
      map { [ @{ $matrix[$_] }[ $max_j .. $max_j + $max_width - 1 ] ] }
      $max_i .. $max_i + $max_height - 1;
}

sub all_zeros {
    my ( $matrix, $i, $j, $height, $width ) = @_;
    return 1 if $width == 0;

    for my $k ( $i .. $i + $height - 1 ) {
        return 0 if $matrix->[$k][ $j + $width ] != 0;
    }

    return 1;
}

my @matrix =
  ( [ 1, 0, 0, 0, 1, 0 ], [ 1, 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 0, 0 ], );

my @result = max_submatrix(@matrix);
foreach my $row (@result) {
    print join( " ", @{$row} ), "\n";
}
