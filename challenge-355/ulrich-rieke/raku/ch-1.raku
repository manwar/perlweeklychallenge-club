use v6 ;

sub chopInThree( $string is copy ) {
    my $result ;
    my $lettercount = 0 ;
    for $string.comb -> $letter {
        $result ~= $letter ;
        $lettercount++ ;
        if ( $lettercount mod 3 == 0 && $lettercount != $string.chars  ) {
            $result ~= "," ;
        }
    }
    return $result ;
}

sub separate( $number ) {
    my $numberstring = ~$number ;
    my $len = $numberstring.chars ;
    if ( $len <= 3 ) {
        return $numberstring ;
    }
    else {
        my $leading_part = $len mod 3 ;
        my $result ;
        if ( $leading_part != 0 ) {
            $result = $numberstring.substr( 0 , $leading_part ) ;
            $result ~= "," ;
            my $rest = $numberstring.substr( $leading_part ) ;
            $result ~= chopInThree( $rest ) ;
        }
        else {
            $result = chopInThree( $numberstring ) ;
        }
        return $result ;
    }
}

for ( 123 , 1234 , 1000000 , 1 , 12345 ) -> $number {
    say separate( $number ) ;
}
