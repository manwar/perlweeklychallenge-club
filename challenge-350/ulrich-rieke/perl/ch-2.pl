#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Storable qw ( freeze ) ;

sub areShuffled {
    my $firstnumber = shift ;
    my $secondnumber = shift ;
    my $len = length $firstnumber ;
    if ( length $firstnumber == length $secondnumber ) {
        my %firsthash ;
        my %secondhash ;
        map { $firsthash{$_}++ } split ( // , $firstnumber ) ;
        map { $secondhash{$_}++ } split( // , $secondnumber ) ;
        my @firstkeys = sort keys %firsthash ;
        my @secondkeys = sort keys %secondhash ;
        if ( freeze(\@firstkeys ) eq freeze(\@secondkeys ) && scalar( @firstkeys ) 
                == $len ) {
            return 1 ;
        }
        else {
            return 0 ;
        }
    }
    else {
        return 0 ;
    }
}

sub findPairs {
    my $from = shift ;
    my $to = shift ;
    my $count = shift ;
    my @pairs ;
    for my $number( $from..$to ) {
        my $foundPairs = 0 ;
        INNER:
        for my $mult( 2..9) {
            if (areShuffled( $number , $mult * $number )) {
                $foundPairs++ ;
                if ( $foundPairs == $count ) {
                    push( @pairs , $number ) ;
                    last INNER ;
                }
            }
        }
    }
    return scalar( @pairs ) ;
}
 
say findPairs( 1 , 1000 , 1 ) ;
say findPairs( 1500 , 2500 , 1 ) ;
say findPairs( 1000000 , 1500000 , 5 ) ;
say findPairs( 13427000 , 14100000 , 2 ) ;
say findPairs( 1030 , 1130 , 1 ) ;
