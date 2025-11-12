#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub monthIndex {
    my $month = shift ;
    my @months = ("Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , 
            "Sep" , "Oct" , "Nov" , "Dec") ;
    my $pos = 0 ;
    while ( $months[$pos] ne $month ) {
        $pos++ ;
    }
    return $pos + 1 ;
}

sub parseDate {
    my $date = shift ;
    my ( $day , $month , $year ) ;
    my $mi ;
    if ( $date =~ /^([1-3]?\d)[strdhn]{2}\s(\w{3})\s([12][091]\d{2})$/ ) {
        ( $day , $month , $year ) = ( $1 , $2 , $3 ) ;
        if ( length $day == 1 ) {
            $day = '0' . $day ;
        }
        $mi = monthIndex( $month ) ;
        if ( length $mi == 1 ) {
            $mi = '0' . $mi ;
        }
    }
    my @parts = ($year , $mi , $day ) ;
    return join( '-' , @parts ) ;
}
say parseDate( "1st Jan 2025") ;
say parseDate( "22nd Feb 2025") ;
say parseDate( "15th Apr 2025") ;
say parseDate( "23rd Oct 2025") ;
say parseDate( "31st Dec 2025") ;
