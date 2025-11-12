use v6 ;

sub monthIndex( $month ) {
    my @months = ("Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , 
            "Sep" , "Oct" , "Nov" , "Dec") ;
    my $pos = 0 ;
    while ( @months[$pos] ne $month ) {
        $pos++ ;
    }
    return $pos + 1 ;
}

sub parseDate( $date ) {
    my ( $year , $day , $month , $mi ) ;
    if ( $date ~~ /^(<[1..3]>?\d) <[strdnh]> ** 2 \s (\w **3) \s (<[12]><[091]>\d ** 2)
            $/ ) {
        ($day , $month , $year ) = ( ~$0 , ~$1 , $2 ) ;
        if ($day.chars == 1) {
            $day = '0' ~ $day ;
        }
        $mi = monthIndex( $month ) ;
    }
    if ( ~$mi.chars == 1 ) {
        $mi = '0' ~ $mi ;
    }
    my @parts = ($year , $mi , $day) ;
    return @parts.join('-') ;
}
say parseDate("1st Jan 2025") ;
say parseDate("22nd Feb 2025") ;
say parseDate( "15th Apr 2025" ) ;
say parseDate( "23rd Oct 2025" ) ;
say parseDate( "31st Dec 2025" ) ;
