#!raku

sub MAIN( Str $phrase = 'The Perl    Weekly Challenge' ) {
    $phrase.split( / \s+ / ).reverse.join( ' ' ).say;
}
