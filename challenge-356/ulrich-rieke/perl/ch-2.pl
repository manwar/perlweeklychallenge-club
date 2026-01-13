#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

#find a seeding order depending on the results of ties represented by
#a string
sub find_ties {
    my $result = shift ;
    my $ties = shift ;
    my @formal_ties ;
    my @seeding_list ; #for the seeding places after the matches
    for my $element( @$ties ) {
        push( @formal_ties , $element ) ;
    }
    my @letters = split( // , $result ) ;
    my @result_pairs = zip( \@letters , \@formal_ties ) ;
    foreach my $pair ( @result_pairs ) {
        if ( $pair->[0] eq 'H' ) {
            push( @seeding_list , $pair->[1]->[0] ) ;
        }
        else {
            push( @seeding_list , $pair->[1]->[1] ) ;
        }
    }
    my @sorted = sort { $a <=> $b } @seeding_list ;
    return @sorted ;
}

sub find_result {
    my $resultstring = shift ;
    my @first_round_ties = ([2 , 7] , [3 , 6] , [4, 5]) ;
    my @first_round_seedings = find_ties( substr( $resultstring , 0 , 3 ) ,
            \@first_round_ties ) ;
    @first_round_seedings = sort { $a <=> $b } @first_round_seedings ;
    my $result ; #for the final output
    my @second_round_ties = ( [1 , $first_round_seedings[2]] , 
       [$first_round_seedings[0] , $first_round_seedings[1] ] ) ;
    my @second_round_seedings = find_ties( substr( $resultstring , 3 , 2 ) ,
            \@second_round_ties ) ;
    if ( substr( $resultstring , 5 , 1 ) eq "H" ) {
        $result = "Team " . $second_round_seedings[0] . " defeated Team " .
            $second_round_seedings[1] ;
    }
    else {
        $result = "Team " . $second_round_seedings[1] . " defeated Team " .
            $second_round_seedings[0] ;
    }
    return $result ;
}

map { say( find_result( $_ )) } ( "HAHAHH" , "HHHHHH" , "HHHAHA" , "HAHAAH" , 
        "HAAHAA" ) ;


