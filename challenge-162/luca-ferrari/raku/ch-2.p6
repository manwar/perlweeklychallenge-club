#!raku

sub build-grid( Str $passprhase ) {
    my @grid;
    my $counter = 0;
    for $passprhase.comb {
        # skip existing letters
        next if @grid.grep( $_ );
        next if $_ !~~ / <[ a .. z ]> /;

        # insert this letter
        @grid.push: $_;
        @grid.push: '|' if ++$counter %% 5;
    }

    # add the other letters
    unless ( @grid.grep( '|' ).elems == 5 ) {
        for 'a' .. 'z' {
            next if @grid.grep( $_ );
            next if $_ ~~ / i /;
            next if $_ ~~ / j /;

            # insert this letter
            @grid.push: $_;
            @grid.push: '|' if ++$counter %% 5;
            last if @grid.grep( '|' ).elems == 5;
        }
    }

    # now split the array into a matrix
    my @matrix;
    for @grid.join.split( '|' ) {
        next if ! $_;
        @matrix.push: [ $_.comb ];
    }

    say @matrix;
    return @matrix;
}


sub build-pairs( Str $needle ) {

    my @mangled;
    my @current;
    for $needle.comb {
        next if $_ ~~ / ' ' /;

        @current.push: $_  if ! @mangled.grep( $_ );
        @current.push: 'X' if   @mangled.grep( $_ );

        if @current.elems == 2 {
            @mangled.push: [@current];
            @current = ();
        }
    }

    return @mangled;
}


sub MAIN() {
    my @key-matrix = build-grid( 'playfair example' );
    my @pairs = build-pairs( 'hide the gold in the tree stump' );


    for @pairs -> @current-pair {
        my @rectangle;

        for 0 ..^ @current-pair {
            my $current_letter = @current-pair[ $_ ];
            my $found = False;

            for 0 ..^ @key-matrix.elems -> $row {
                for 0 ..^ 5 -> $column {
                    if @key-matrix[ $row ][ $column ] ~~ $current_letter {
                        # found!
                        @rectangle.push: ( row => $row, col => $column ).Hash;
                        $found = True;
                    }

                    last if $found;
                }

                last if $found;
            }
        }

        say @current-pair.join;
        say @rectangle;

        say @rectangle[ 0 ].^name;
#        my $is-rectangle = @rectangle[ 0 ]{ row } != @rectangle[ 1 ]{ row } && @rectangle[ 0 ]{ col } != @rectangle[ 1 ]{ col };
#       say "rettangolo $is-rectangle";
    }
}
