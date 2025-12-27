#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some codes separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @codes = split( /\s/ , $line ) ;
say "Enter some names separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @names = split( /\s/ , $line ) ;
say "Enter some status words true or false separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @status = split( /\s/ , $line ) ;
my %nametypes ;
$nametypes{"grocery"}++ ;
$nametypes{"restaurant"}++ ;
$nametypes{"pharmacy"}++ ;
$nametypes{"electronics"}++ ;
my @result ;
for my $i (0..scalar( @codes ) - 1 ) {
    if ( $codes[$i] =~ /^\w+$/  && exists( $nametypes{ $names[$i] } ) && 
        $status[$i] eq "true" ) {
        push( @result , "true" ) ;
    }
    else {
        push( @result , "false" ) ;
    }
}
say '(' . join( ',' , @result ) . ')' ;
