#!raku

sub MAIN( Int $top where { $top > 1 } ) {
    my @solutions;
    @solutions.push: 1 xx $top;

    my $current-solution = 1 x $top;
    while ( $current-solution ~~ / 1 ** 2 / ) {
        $current-solution ~~ s/ 1 ** 2 / 2 /;
        $current-solution = $current-solution.split( ' ', :skip-empty  ).join( '' );
        @solutions.push: $_ for $current-solution.split( '', :skip-empty ).permutations.unique( as => { .Str.trim } );
        
        
    }
    
    
    for @solutions -> @current-solution {
        say "\nPossible solution:";
        "%d step%s ".sprintf( $_, $_ > 1 ?? 's' !! '' ).print if $_ > 0 for @current-solution;
        
    }

    say "";
    
}

