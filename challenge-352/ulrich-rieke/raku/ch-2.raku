use v6 ;

sub convert( @digits ) {
    my @truthvalues ;
    my $len = @digits.elems ;
    my $pos = 0 ;
    my $numberstring ;
    while ( @digits[$pos] == 0 ) {
        @truthvalues.push( True ) ;
        $pos++ ;
    }
    for ($pos..$len - 1 ) -> $i {
        $numberstring ~= ~@digits[$i] ;
        my $number = $numberstring.parse-base( 2 ) ;
        @truthvalues.push( $number %% 5 ) ;
    }
    return @truthvalues ;
}

say "Enter some 0 or 1 separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say '(' ~ join( ',' , convert( @numbers )) ~ ')' ;

