use v6 ;

sub handleRest( $rest ) {
    my $len = $rest.chars ;
    my $result ;
    if ( $len == 2 || $len == 3 ) {
        $result = $rest ;
    }
    else {
        $result = $rest.substr( 0 , 2 ) ~ '-' ~ $rest.substr( 2 ) ;
    }
    return $result ;
}

sub printParts( @parts ) {
    if ( @parts.elems == 1 ) {
        say @parts[0] ;
    }
    else {
        say @parts.join( '-' ) ;
    }
}

say "Enter a telephone number containing digits , space and dashes only!" ;
my $phonenumber = $*IN.get ;
$phonenumber ~~ s:g/(\s|'-')// ;
my $len = $phonenumber.chars ;
if ( $len <= 4 ) {
    say handleRest( $phonenumber ) ;
}
else {
    my @parts ;
    my $partnumber = $len div 3 ;
    my $lengthrest = $len % 3 ;
    if ( $lengthrest != 0 && $lengthrest < 2 ) {
        $partnumber-- ;
    }
    my $pos = 0 ;
    my $i = 0 ;
    while ( $i < $partnumber ) {
        @parts.push( $phonenumber.substr( $pos , 3 ) ) ;
        $pos += 3 ;
        $i++ ;
    }
    my $restlen = $len - $partnumber * 3 ;
    if ( $restlen == 0 ) {
        printParts( @parts ) ;
    }
    else {
        my $rest = $phonenumber.substr( $partnumber * 3 ) ;
        @parts.push( handleRest( $rest ) ) ;
        printParts( @parts ) ;
    }
}
