#!raku

sub is-mine( @input, $row, $column ) {
    return @input[ $row ][ $column ] ~~ 'x';
}


sub compute-mines( @input, $row, $column ) {
    my $counter = 0;

    # see where we can move
    my ( $can-left, $can-right, $can-up, $can-down ) =
         $column > 0, $column < @input[ 0 ].elems, $row > 0, $row < @input.elems;


    # left, if possible
    $counter++  if ( $can-left && is-mine( @input, $row, $column - 1 ) );
    # up if possible
    $counter++  if ( $can-up && is-mine( @input, $row - 1, $column ) );
    # down if possible
    $counter++  if ( $can-down && is-mine( @input, $row + 1 , $column ) );
    # right if possible
    $counter++  if ( $can-right && is-mine( @input, $row, $column + 1 ) );


    # left up
    $counter++  if ( $can-left && $can-up && is-mine( @input, $row - 1, $column - 1 ) );
    # right up
    $counter++  if ( $can-up &&  $can-right && is-mine( @input, $row - 1, $column + 1 ) );
    # left down
    $counter++  if ( $can-left && $can-down && is-mine( @input, $row + 1, $column - 1 ) );
    # right down
    $counter++  if ( $can-down && $can-right && is-mine( @input, $row + 1, $column + 1 ) );

    # left up if possible


    return $counter;
}


sub MAIN() {
    my @input =
     qw/ x * * * x * x x x x /,
     qw/ * * * * * * * * * x /,
     qw/ * * * * x * x * x * /,
     qw/ * * * x x * * * * * /,
     qw/ x * * * x * * * * x /;

    my $rows = @input.elems;
    my $columns = @input[ 0 ].elems;


    

    my ( $current-row, $current-column ) = 0, 0;
    for 0 ..^ $rows -> $current-row {
        for 0 ..^ $columns -> $current-column {
            print is-mine( @input, $current-row, $current-column ) ?? 'x'
                      !! compute-mines( @input, $current-row, $current-column );
        }

        print "\n";
    }
}
