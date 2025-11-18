#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub solution {
    my $word = shift ;
    my $vowels = "AaeEiIoOuU" ;
    my $firstvowels = 0 ;
    my $secondvowels = 0 ;
    my $len = length $word ;
    for my $c( split( // , substr( $word , 0 , $len / 2 ))) {
        if ( index($vowels , $c) != -1 ) {
            $firstvowels++ ;
        }
    }
    for my $c ( split( // , substr( $word , $len / 2 ))) {
        if ( index( $vowels , $c ) != -1 ) {
            $secondvowels++ ;
        }
    }
    if ( $firstvowels == $secondvowels ) {
        return "true" ;
    }
    else {
        return "false" ;
    }
}
say solution("textbook") ;
say solution( "book" ) ;
say solution( "AbCdEfGh" ) ;
say solution( "rhythmmyth" ) ;
say solution( "UmpireeAudio" ) ;


