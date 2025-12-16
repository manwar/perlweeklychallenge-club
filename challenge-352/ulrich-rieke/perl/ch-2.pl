#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub to_decimal {
    my $numberstring = shift ;
    my $decimal = 0 ;
    $numberstring = join( '' , reverse( split( // , $numberstring ) )) ;
    my $current = 1 ;
    my $len = length $numberstring ;
    for my $pos( 0..$len - 1 ) {
        $decimal += $current * substr( $numberstring , $pos , 1 ) ;
        $current *= 2 ;
    }
    return $decimal ;
}

sub convert {
    my $array = shift ;
    my @result ;
    my $len = scalar( @$array ) ;
    my $pos = 0 ;
    my $numberstring ;
    while ( $array->[$pos] == 0 ) {
        push( @result  , "true" ) ;
        $pos++ ;
    }
    for my $i ($pos..$len - 1) {
        $numberstring .= $array->[$i] ;
        my $number = to_decimal( $numberstring ) ;
        if ( $number % 5 == 0 ) {
            push( @result , "true" ) ;
        }
        else {
            push( @result , "false" ) ;
        }
    }
    return @result ;
}

say "Enter some 0 or 1 separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say '(' . join( ',' , convert( \@numbers )) . ')' ;
