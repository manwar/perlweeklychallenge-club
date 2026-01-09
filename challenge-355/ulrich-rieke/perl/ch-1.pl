#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub chopInThree {
    my $string = shift ;
    my $len = length $string ;
    my $lettercount = 0 ;
    my $result ;
    for my $letter( split( // , $string ) ) {
        $result .= $letter ;
        $lettercount++ ;
        if ( $lettercount % 3 == 0 && $lettercount != $len ) {
            $result .= "," ;
        }
    }
    return $result ;
}

sub separate {
    my $number = shift ;
    my $len = length $number ;
    if ( $len <= 3 ) {
        return $number ;
    }
    else {
        my $result ;
        my $leading_part = $len % 3 ;
        if ( $leading_part != 0 ) {
            $result = substr( $number , 0 , $leading_part ) ;
            $result .= "," ;
            my $rest = substr( $number , $leading_part ) ;
            $result .= chopInThree( $rest ) ;
        }
        else {
            $result = chopInThree( $number ) ;
        }
        return $result ;
    }
}

for my $number( 123 , 1234 , 1000000 , 1 , 12345 ) {
    say separate( $number ) ;
}
