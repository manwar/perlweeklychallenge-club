package Knight;

use Moo;

has treasures => ( is => 'ro', );

has collected_treasures => (
    is      => 'rw',
    default => sub { return []; },
);

sub go {
    my ( $self, %args ) = @_;

    my $targets              = $self->treasures;
    my $treasures_to_collect = @$targets;
    my $row                  = 7;
    my $col                  = 0;

    my @path;
    while ( $treasures_to_collect > 0 ) {
        push @path, [ $row, $col ];
        if ( $self->has_treasure( $row, $col ) ) {
            if ( !$self->have_we_got_this_treasure( $row, $col ) ) {
                $self->collect_treasure( $row, $col );
                $treasures_to_collect--;
            }
        }
        my $new = $self->move( $row, $col );
        $row = $new->[0];
        $col = $new->[1];
    }

    return {
        treasures => $self->collected_treasures,
        path      => \@path,
        moves     => @path -1, # sub 1 as path includes starting position.
    };
}

sub move {
    my ( $self, $row, $col ) = @_;

    # Directions: 0 -> up left    (row +2, col -1)
    # Directions: 1 -> up right   (row +2, col +1)
    # Directions: 2 -> right up   (row +1, col +2)
    # Directions: 3 -> right down (row -1, col +2)
    # Directions: 4 -> down right (row -2, col +1)
    # Directions: 5 -> down left  (row -2, col -1)
    # Directions: 6 -> left down  (row -1, col -2)
    # Directions: 7 -> left up    (row +1, col -2)

    my $new_row;
    my $new_col;

    while (1) {
        my $direction = int rand(8);
        $new_row = 0;
        $new_col = 0;

        if ( $direction == 0 ) { $new_col = $col - 1; $new_row = $row + 2; }
        if ( $direction == 1 ) { $new_col = $col + 1; $new_row = $row + 2; }
        if ( $direction == 2 ) { $new_col = $col + 2; $new_row = $row + 1; }
        if ( $direction == 3 ) { $new_col = $col + 2; $new_row = $row - 1; }
        if ( $direction == 4 ) { $new_col = $col + 1; $new_row = $row - 2; }
        if ( $direction == 5 ) { $new_col = $col - 1; $new_row = $row - 2; }
        if ( $direction == 6 ) { $new_col = $col - 2; $new_row = $row - 1; }
        if ( $direction == 7 ) { $new_col = $col - 2; $new_row = $row + 1; }

        if ( $new_col < 8 && $new_col >= 0 && $new_row < 8 && $new_row >= 0 )
        {
            last;
        }
    }
    return [ $new_row, $new_col ];
}

sub has_treasure {
    my ( $self, $row, $col ) = @_;
    return unless defined $row && defined $col;

    for my $treasure ( @{ $self->treasures } ) {
        return unless defined $treasure;
        if ( $treasure->[0] == $row && $treasure->[1] == $col ) {
            return 1;
        }
    }
    return 0;
}

sub have_we_got_this_treasure {
    my ( $self, $row, $col ) = @_;

    for my $target ( @{ $self->collected_treasures } ) {
        if ( $target->[0] == $row && $target->[1] == $col ) {
            return 1;
        }
    }
    return 0;
}

sub collect_treasure {
    my ( $self, $row, $col ) = @_;
    push @{ $self->collected_treasures }, [ $row, $col ];
}

1;
