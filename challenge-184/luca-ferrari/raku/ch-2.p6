#!raku

# Perl Weekly Challenge 184

sub MAIN( *@strings ) {
    my @numbers;
    my @letters;

    for @strings -> $current-string {
        my ( @n, @l );
        for $current-string.comb {
            @n.push: $_ if ( $_ ~~ / \d / );
            @l.push: $_ if ( $_ ~~ / <[a..z]> / );
        }

    @numbers.push: [ @n ] if ( @n );
    @letters.push: [ @l ] if ( @l );
    }

    @numbers.join( ", " ).say;
    @letters.join( ", " ).say;
}
