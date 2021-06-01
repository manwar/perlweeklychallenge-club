#!raku

sub MAIN( *@words  where { @words.elems > 0 } ) {

    # get a list of all initiali letters
    # and one of all tailing ones
    my @headings = @words.map: *.substr( 0, 1 );
    my @tailings = @words.map: *.substr( * - 1 );

    # if the sorted list are the same, there is a match!
    say @headings.sort ~~ @tailings.sort ?? 1 !! 0;

}
