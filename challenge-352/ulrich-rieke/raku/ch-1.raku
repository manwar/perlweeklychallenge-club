use v6 ;

say "Enter some strings separated by blanks!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my @result ;
for @allWords -> $word {
    my @selected = @allWords.grep( {$_ ne $word && $_ ~~ /$word/ } ) ;
    if ( @selected ) {
        @result.push( $word ) ;
    }
}
@result .= unique ;
say '(' ~ join( ',' , @result ) ~ ')' ;
