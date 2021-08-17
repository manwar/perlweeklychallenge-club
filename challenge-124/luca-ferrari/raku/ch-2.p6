#!raku

sub MAIN( *@S where { @S.elems == @S.grep( * ~~ Int ).elems && @S.elems > 0 } ) {
    my $split-pos = do given @S.elems %% 2 {
        when .so { @S.elems / 2 }
        default { ( @S.elems - 1 ) / 2 }
    };

    my $min-diff;
    my $sum = ( @S.sum / 2 ).Int.floor;
    my @solution;

    for @S.combinations: $split-pos -> @current-set {
        my $diff = ( $sum - @current-set.sum ).Int.abs;
        if ( ! $min-diff || $min-diff > $diff ) {
            @solution = @current-set.clone;
            $min-diff = $diff;
        }
    }

    # assume each number appears one and only one
    my @anti-solution;
    for @S {
        @anti-solution.push: $_ if ! @solution.grep( $_ );
    }

    say "Sets are { @solution.join( ',' ) } and { @anti-solution.join( ',' ) }";
}

