#!raku

# Perl Weekly Challenge 184

sub MAIN( *@strings where { @strings.grep( $_ ~~ / ^ <[a..z]> ** 2 \d ** 4 $/ ).elems == @strings.elems } ) {
    my $counter = 0;
    my @ordered-strings = @strings.map: {
        my $s = $_;
        $s ~~ s/ ^ ( <[a..z]> ** 2 ) /{ "%02d".sprintf( $counter++ ) }/;
        $s; };
    @ordered-strings.join( "\n" ).say;

}
