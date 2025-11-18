use v6 ;

sub solution( $word ) {
    my $vowels = "aAeEiIoOuU".comb.Set ;
    my $len = $word.chars ;
    my $firstvowels = $word.substr(0 , $len div 2).comb.grep( {$_ (elem) $vowels} ).
        elems ;
    my $secondvowels = $word.substr( $len div 2 ).comb.grep( {$_ (elem) $vowels} ).
        elems ;
    return $firstvowels == $secondvowels ;
}
say( solution( "textbook" )) ;
say( solution( "book" ) ) ;
say( solution( "AbCdEfGh" )) ;
say( solution( "rhythmmyth" )) ;
say( solution ( "UmpireeAudio" ) ) ;
