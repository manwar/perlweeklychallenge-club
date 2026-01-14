#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an integer greater than 3!" ;
my $number = <STDIN> ;
chomp $number ;
my @kolakoski ;
my $i = 1 ;
while ( scalar( @kolakoski ) < $number ) {
    if ( not @kolakoski ) {
        push( @kolakoski , 1 ) ;
    }
    else {
        my $pushed = 0 ;
        if ( scalar( @kolakoski ) < $i ) {
            push( @kolakoski , $i ) ;
            $pushed = 1 ;
        }
        if ( $i % 2 == 1 ) {
            if ( not $pushed ) {
                for (0..$kolakoski[$i - 1] - 1 ) {
                    push( @kolakoski, 1 ) ;
                }
            }
            else {
                push( @kolakoski , 1 ) ;
            }
        }
        else {
            if ( not $pushed ) {
                for (0..$kolakoski[$i - 1] - 1) {
                    push( @kolakoski, 2 ) ;
                }
            }
            else {
                push( @kolakoski, 2 ) ;
            }
        }
    }
    $i++ ;
}
say scalar( grep { $_ == 1 } @kolakoski[0..$number - 1] ) ;
